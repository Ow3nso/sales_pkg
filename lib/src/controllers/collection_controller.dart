// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DynamicLinkServices,
        FieldValue,
        FirebaseFirestore,
        NavigationService,
        ReadContext,
        Share,
        Shop,
        ShopCollection,
        ShopCollectionFields,
        ShortMessageType,
        ShortMessages,
        StorageUtils,
        UserRepository,
        Uuid;
import 'package:sales_pkg/src/controllers/products_controller.dart';

import '../pages/product/pages/product_collection_view.dart';
import 'add_item_controller.dart';

class CollectionController extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  Map<String, ShopCollection> _collections = {};
  Map<String, ShopCollection> get collections => _collections;
  set collections(Map<String, ShopCollection> collections) {
    _collections = collections;
    notifyListeners();
  }

  TextEditingController nameTextController = TextEditingController();

  bool get hasCollections => collections.isNotEmpty;

  Map<String, bool> _collectionBeingShared = {};

  Map<String, bool> get collectionBeingShared => _collectionBeingShared;

  set collectionBeingShared(Map<String, bool> collectionBeingShared) {
    _collectionBeingShared = collectionBeingShared;
    notifyListeners();
  }

  void updateCollectionBeingShared(String collectionId, bool isBeingShared) {
    collectionBeingShared = {
      ...collectionBeingShared,
      collectionId: isBeingShared
    };
  }

  bool collectionIsBeingShared(String collectionId) {
    return collectionBeingShared[collectionId] ?? false;
  }

  void clearCollectionBeingShared() {
    collectionBeingShared = {};
  }

  bool get hasCollectionBeingShared => collectionBeingShared.isNotEmpty;

  Future<bool> getShopCollection({bool isRefresh = false}) async {
    if (hasCollections && !isRefresh) return Future.value(true);
    BuildContext context = NavigationService.navigatorKey.currentState!.context;
    final userRepo = context.read<UserRepository>();
    final shopId = userRepo.shop?.shopId;
    if (shopId == null) return Future.value(false);
    final shopCollections = await db
        .collection(StorageUtils.shopCollectionsPath(shopId))
        .orderBy(ShopCollectionFields.createdAt, descending: true)
        .get();
    if (shopCollections.docs.isNotEmpty) {
      collections = {
        for (var e in shopCollections.docs)
          e.id: ShopCollection.fromJson(e.data())
      };
    }
    return Future.value(true);
  }

  Future<bool> addCollection() {
    final collectionName = nameTextController.text;
    if (collectionName.isEmpty) {
      ShortMessages.showShortMessage(
          message: "Collection name cannot be empty",
          type: ShortMessageType.error);
      return Future.value(false);
    }
    BuildContext context = NavigationService.navigatorKey.currentState!.context;
    final userRepo = context.read<UserRepository>();
    final shopId = userRepo.shop?.shopId;
    if (shopId == null) {
      ShortMessages.showShortMessage(
          message:
              "You cannot create a collection without having a registered shop",
          type: ShortMessageType.error);
      return Future.value(false);
    }
    ShopCollection shopCollection = ShopCollection.empty();
    shopCollection = shopCollection.copyWith(
        docId: const Uuid().v4(),
        shopId: userRepo.shop?.shopId,
        userId: userRepo.user?.userId,
        name: collectionName);

    try {
      db
          .collection(StorageUtils.shopCollectionsPath(shopId))
          .doc(shopCollection.docId)
          .set(shopCollection.toJson());
      ShortMessages.showShortMessage(
          message: "Collection created successfully",
          type: ShortMessageType.success);
      getShopCollection(isRefresh: true);
    } catch (e) {
      if (kDebugMode) {
        log('An error occurred while creating a collection: $e');
      }
      ShortMessages.showShortMessage(
          message:
              'An error occurred while creating $collectionName collection',
          type: ShortMessageType.error);
      return Future.value(false);
    }

    return Future.value(true);
  }

  Future<bool> addProductsToCollection(
      {required List<String> productIds, required String collectionId}) {
    BuildContext context = NavigationService.navigatorKey.currentState!.context;
    final userRepo = context.read<UserRepository>();
    final shopId = userRepo.shop?.shopId;
    if (shopId == null) {
      ShortMessages.showShortMessage(
          message:
              "You cannot add products to a collection without having a registered shop",
          type: ShortMessageType.error);
      return Future.value(false);
    }
    try {
      db
          .collection(StorageUtils.shopCollectionsPath(shopId))
          .doc(collectionId)
          .update({
        ShopCollectionFields.productIds: FieldValue.arrayUnion(productIds)
      });
      context.read<ProductController>().clearselectedProducts();
      ShortMessages.showShortMessage(
          message: "Products added to collection successfully",
          type: ShortMessageType.success);
      getShopCollection(isRefresh: true);
    } catch (e) {
      if (kDebugMode) {
        log('An error occurred while adding products to a collection: $e');
      }
      ShortMessages.showShortMessage(
          message: 'An error occurred while adding products to a collection',
          type: ShortMessageType.error);
      return Future.value(false);
    }

    return Future.value(true);
  }

  Future<void> shareCollectionLink({
    required BuildContext context,
    required ShopCollection shopCollection,
     File? gridImage
  }) async {
    if (shopCollection.productIds == null) {
      ShortMessages.showShortMessage(
          message:
              "Collection is empty, for a collection to be shared it must have at least one product",
          type: ShortMessageType.warning);
      return;
    }

    if (collectionIsBeingShared(shopCollection.id!)) {
      ShortMessages.showShortMessage(
          message: "Collection is already being shared",
          type: ShortMessageType.warning);
      return;
    }
    updateCollectionBeingShared(shopCollection.docId!, true);
    final userRepo = context.read<UserRepository>();
    final productController = context.read<ProductController>();
    final productUploadController = context.read<UploadProductController>();
    String? mediaUrl;
    List<String> productsHeroImages = [];
    final productIds = shopCollection.productIds!;

    /// Add product related images
    for (var productId in productIds) {
      final product = productController.products[productId];
      if (product != null) {
        if (product.heroImage != null) {
          productsHeroImages.add(product.heroImage!);
        }
      }
    }
    // make sure we have at most 10 images
    if (productsHeroImages.length > 10) {
      productsHeroImages = productsHeroImages.sublist(0, 10);
    }

    if (gridImage != null) {
      await productUploadController.uploadFile(
        gridImage,
        context,
        shopCollection.docId!,
        callBack: (imageUrl) async {
          if(kDebugMode){
            log('Image uploaded successfully, link : $imageUrl');
          }
          await _generateColletionLinkAndShare(
              shopCollection: shopCollection,
              mediaUrl: mediaUrl,
              shop: userRepo.shop!);
          return;
        },
      );
    } else {
      mediaUrl = productsHeroImages.first;
      await _generateColletionLinkAndShare(
          shopCollection: shopCollection,
          mediaUrl: mediaUrl,
          shop: userRepo.shop!);
    }
  }

  /// This function generates a dynamic link for a shop collection and shares it via the device's share
  /// functionality.
  ///
  /// Args:
  ///   shopCollection (ShopCollection): An object of type ShopCollection which contains information
  /// about a collection of products in a shop.
  ///   mediaUrl (String): The mediaUrl parameter is a String that represents the URL of the media (e.g.
  /// image or video) associated with the shop collection.
  ///   shop (Shop): The `shop` parameter is an instance of the `Shop` class, which represents a shop in
  /// the application. It is required for generating the dynamic link and is used in the link description
  /// to indicate which shop the collection belongs to.
  Future<void> _generateColletionLinkAndShare(
      {required ShopCollection shopCollection,
      required String? mediaUrl,
      required Shop shop}) async {
    BuildContext context = NavigationService.navigatorKey.currentState!.context;
    String? link;
    try {
      link = await DynamicLinkServices.createLink(
          context: context,
          mediaUrl: mediaUrl,
          appPath: ProductCollectionView.routeName,
          title: shopCollection.name!,
          description: "View ${shopCollection.name} collection on ${shop.name}",
          params: {
            "colletionId": shopCollection.docId!,
          });
    } catch (e) {
      if (kDebugMode) log('An error occurred while generating link: $e');
    }
    if (link != null) {
      _updateCollectionlink(collectionId: shopCollection.docId!, link: link);
      await Share.share(link);
    } else {
      ShortMessages.showShortMessage(
          message: 'An error occurred while generating link',
          type: ShortMessageType.error);
    }

    updateCollectionBeingShared(shopCollection.docId!, false);
    clearCollectionBeingShared();
  }

  /// This function updates the link of a collection in the Firestore database for a registered shop.
  ///
  /// Args:
  ///   collectionId (String): A required String parameter representing the ID of the collection to be
  /// updated.
  ///   link (String): The link parameter is a required String that represents the URL link to be updated
  /// for a specific collection.
  ///
  /// Returns:
  ///   A `Future<void>` is being returned.
  Future<void> _updateCollectionlink({
    required String collectionId,
    required String link,
  }) {
    BuildContext context = NavigationService.navigatorKey.currentState!.context;
    final userRepo = context.read<UserRepository>();
    final shopId = userRepo.shop?.shopId;
    if (shopId == null) {
      ShortMessages.showShortMessage(
          message:
              "You cannot add products to a collection without having a registered shop",
          type: ShortMessageType.error);
      return Future.value();
    }
    try {
      db
          .collection(StorageUtils.shopCollectionsPath(shopId))
          .doc(collectionId)
          .update({ShopCollectionFields.link: link});
    } catch (e) {
      if (kDebugMode) {
        log('An error occurred while adding products to a collection: $e');
      }
      ShortMessages.showShortMessage(
          message: 'An error occurred while adding products to a collection',
          type: ShortMessageType.error);
      return Future.value();
    }

    return Future.value();
  }
}
