// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppDBConstants,
        DynamicLinkServices,
        FirebaseFirestore,
        FirebaseStorage,
        GlobalAppUtil,
        NavigationService,
        Product,
        ProductFields,
        ProductInfoView,
        ReadContext,
        ShortMessageType,
        ShortMessages,
        UserRepository;
import '../pages/product/widgets/share_qr_card.dart';
import '../widgets/dialogue.dart';
import 'discount_controller.dart';

/// > This class is used to control the products
/// > It gets the products from the database and stores them in the products map
/// > It returns true if the products are gotten successfully
class ProductController extends ChangeNotifier {
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final String _collection = AppDBConstants.productsCollection;
  late TextEditingController searchController;

  Map<String, Product> _products = {};

  /// > This is the products map
  Map<String, Product> get products => _products;
  set products(Map<String, Product> products) {
    _products = products;
    notifyListeners();
  }

  Map<String, bool> _loadingProductLinks = {};

  /// > This is the loading product links map
  Map<String, bool> get loadingProductLinks => _loadingProductLinks;
  set loadingProductLinks(Map<String, bool> loadingProductLinks) {
    _loadingProductLinks = loadingProductLinks;
    notifyListeners();
  }

  ProductController() {
    searchController = TextEditingController();
  }

  Map<String, String> _loadedProductLinks = {};

  /// > This is the loaded product links map
  Map<String, String> get loadedProductLinks => _loadedProductLinks;

  set loadedProductLinks(Map<String, String> loadedProductLinks) {
    _loadedProductLinks = loadedProductLinks;
    notifyListeners();
  }

  /// This function updates the product link for a given product ID and notifies any listeners of the
  /// change.
  ///
  /// Args:
  ///   productId (String): A required String parameter representing the unique identifier of a product.
  ///   productLink (String): A required String parameter representing the updated link for a product.
  void updateProductLink(
      {required String productId, required String productLink}) {
    loadedProductLinks[productId] = productLink;
    notifyListeners();
  }

  Color? getProductColor(Product? value, String? colorValue) {
    Color? color;
    if (colorValue != null) {
      color = GlobalAppUtil.optionColors
          .firstWhere((data) => data['name'] == colorValue)['color'];
    }
    return color;
  }

  String? _selectedColor = '';
  String? get selectedColor => _selectedColor;
  set selectedColor(String? value) {
    _selectedColor = value;
    notifyListeners();
  }

  String? _selectedSize;
  String? get selectedSize => _selectedSize;

  set selectedSize(String? value) {
    _selectedSize = value;

    notifyListeners();
  }

  List<Map<String, dynamic>> optionColors(Product? value) {
    var colors = <Map<String, dynamic>>[];
    if (value != null) {
      for (var element in GlobalAppUtil.optionColors) {
        if (value.availableColors!.any((color) => element['name'] == color)) {
          colors.add(element);
        }
      }
    }
    return colors;
  }

  /// This function sets the loading status of a product link and notifies listeners.
  ///
  /// Args:
  ///   productId (String): A required parameter of type String that represents the unique identifier of a
  /// product.
  ///   isLoading (bool): isLoading is a boolean parameter with a default value of true. It is used to
  /// indicate whether the product link is currently being loaded or not. If it is set to true, it means
  /// that the product link is being loaded, and if it is set to false, it means that the loading has
  /// finished. Defaults to true
  void setLoadingProductLink(
      {required String productId, bool isLoading = true}) {
    loadingProductLinks[productId] = isLoading;
    notifyListeners();
  }

  /// This function checks if a product link is currently loading based on its ID.
  ///
  /// Args:
  ///   productId (String): The productId is a required parameter of type String that is used to identify
  /// a specific product. It is used as a key to access the loading status of the product link in the
  /// loadingProductLinks map.
  ///
  /// Returns:
  ///   a boolean value, which is either the value of the `loadingProductLinks` map for the given
  /// `productId`, or `false` if the `productId` is not found in the map.
  bool productLinkIsLoading({required String productId}) {
    return loadingProductLinks[productId] ?? false;
  }

  /// This function generates a dynamic link for a product and returns it, or returns null if an error
  /// occurs.
  ///
  /// Args:
  ///   product (Product): A required parameter of type Product, which represents the product for which
  /// the link is being created.
  ///   context (BuildContext): The BuildContext is a required parameter that represents the location of
  /// the widget in the widget tree. It is used to access the Theme, MediaQuery, and other widgets in the
  /// tree.
  ///
  /// Returns:
  ///   The method is returning a `Future` that resolves to a `String` or `null`.
  Future<String?> getProductLink(
      {required Product product, required BuildContext context}) async {
    setLoadingProductLink(productId: product.productId!);
    if (loadedProductLinks.containsKey(product.productId!)) {
      setLoadingProductLink(productId: product.productId!, isLoading: false);
      return loadedProductLinks[product.productId!];
    }
    try {
      var productLink = await DynamicLinkServices.createLink(
        context: context,
        appPath: ProductInfoView.routeName,
        params: {'productId': product.productId!},
        title: product.label!,
        description: product.description!,
        mediaUrl: product.heroImage,
      );
      setLoadingProductLink(productId: product.productId!, isLoading: false);
      updateProductLink(
          productId: product.productId!, productLink: productLink);
      return productLink;
    } catch (e) {
      ShortMessages.showShortMessage(
          type: ShortMessageType.error,
          message:
              'An error occurred while creating the product link, please try again');
      setLoadingProductLink(productId: product.productId!, isLoading: false);
      return null;
    }
  }

  /// > It gets the products from the database and stores them in the products map
  /// > It returns true if the products are gotten successfully
  /// > It returns false if the products are not gotten successfully
  /// > It returns true if the products are already gotten
  /// > It returns false if the products are not gotten and the context is null
  /// > It returns false if the products are not gotten and an error occurs
  /// > It returns false if the products are not gotten and the products are empty

  Future<bool> getProducts({bool isrefreshMode = false}) async {
    if (products.isNotEmpty && !isrefreshMode) return true;
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context == null) return false;
    try {
      var productsDocs = await db
          .collection(_collection)
          .where(ProductFields.sellerId,
              isEqualTo: context.read<UserRepository>().fbUser!.uid)
          .orderBy(ProductFields.createdAt, descending: true)
          .get();
      if (productsDocs.docs.isNotEmpty) {
        products = {
          for (var e in productsDocs.docs) e.id: Product.fromJson(e.data())
        };
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        log('An error occurred while getting products: $e');
      }
    }
    return false;
  }

  Future<void> searchProduct() async {
    if (searchController.text.isEmpty) return;
    var list = products.values.toList();
    var searchedProduct = list
        .where((value) => value.description!
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    if (searchedProduct.isNotEmpty) {
      products = {for (var e in searchedProduct) e.productId!: e};
    }
  }

  /// It sets the discount of a product
  ///
  /// Args:
  ///   productId (String): The id of the product you want to set the discount for.
  ///   value (double): The value of the discount.
  ///   type (String): The type of discount you want to set. It can be either a percentage or a fixed
  /// amount. Defaults to ProductFields
  ///
  /// Returns:
  ///   Future<bool>
  Future<bool> setDiscount(
      {required List<String> productIds,
      required double value,
      String type = ProductFields.discountPercentage}) async {
    if (type == ProductFields.discountPercentage) {
      for (var productId in productIds) {
        products[productId] = products[productId]!.copyWith(
            discountPercentage: value, isOnDiscount: true, discountAmount: 0);
      }
    } else {
      for (var productId in productIds) {
        products[productId] = products[productId]!.copyWith(
            discountAmount: value, isOnDiscount: true, discountPercentage: 0);
      }
    }
    notifyListeners();

    await Future.wait(productIds
        .map((productId) => updateProduct(productId: productId, productData: {
              type: value,
              ProductFields.isOnDiscount: true,
            })));
    BuildContext? context =
        NavigationService.navigatorKey.currentState?.context;
    if (context != null) {
      context.read<DiscountController>().clearSeletedDiscounts(productIds);
      ShortMessages.showShortMessage(
          type: ShortMessageType.success, message: 'Discount set successfully');
    }

    return true;
  }

  /// It removes the discount of a product
  /// Args:
  ///  productId (String): The id of the product you want to remove the discount for.
  /// Returns:
  /// Future<bool>
  Future<bool> removeProductsDiscount(
      {required List<String> productIds}) async {
    for (var productId in productIds) {
      products[productId] = products[productId]!.copyWith(
          discountPercentage: 0, discountAmount: 0, isOnDiscount: false);
    }
    notifyListeners();

    await Future.wait(productIds
        .map((productId) => updateProduct(productId: productId, productData: {
              ProductFields.discountPercentage: 0,
              ProductFields.discountAmount: 0,
              ProductFields.isOnDiscount: false,
            })));
    ShortMessages.showShortMessage(
        type: ShortMessageType.success,
        message: 'Discount removed successfully');
    return true;
  }

  /// It updates a product in the database
  ///
  /// Args:
  ///   productId (String): The id of the product to be updated.
  ///   productData (Map<String, dynamic>): A map of the product data.
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> updateProduct(
      {required String productId,
      required Map<String, dynamic> productData}) async {
    if (!isValidProductData(data: productData)) {
      if (kDebugMode) {
        log('Invalid product data: $productData');
      }
      return false;
    }
    try {
      await db.collection(_collection).doc(productId).update(productData);
    } catch (e) {
      if (kDebugMode) {
        log('An error occurred while updating product: $e');
      }
      return false;
    }
    return true;
  }

  /// `isValidProductData` returns `true` if all the keys in the `data` map are valid product fields
  ///
  /// Args:
  ///   data (Map<String, dynamic>): The data to be validated.
  ///
  /// Returns:
  ///   A boolean value.
  bool isValidProductData({required Map<String, dynamic> data}) {
    for (var element in data.keys) {
      if (!ProductFields.values.contains(element)) return false;
    }
    return true;
  }

  /// It deletes a product from the database and deletes all the images associated with that product
  ///
  /// Args:
  ///   productId (String): The id of the product to be deleted.
  ///   userId (String): The userId of the user who is deleting the product.
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> deleteProduct({required String productId}) async {
    try {
      await db.collection(_collection).doc(productId).delete();
      final mediaPath = products[productId]!.mediaPath;
      products.remove(productId);
      notifyListeners();
      deleteProductImages(mediaPath: mediaPath!);
      ShortMessages.showShortMessage(
          type: ShortMessageType.success,
          message: 'Product deleted, successfully');
    } catch (e) {
      if (kDebugMode) {
        log('An error occurred while deleting product: $e');
      }
      ShortMessages.showShortMessage(
          type: ShortMessageType.error,
          message: 'An error occurred, try again');
      return false;
    }
    return true;
  }

  /// It deletes all the images of a product
  ///
  /// Args:
  ///   productId (String): The product id of the product whose images are to be deleted.
  ///   userId (String): The user id of the user who uploaded the product.
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> deleteProductImages({required String mediaPath}) async {
    try {
      var images = await storage.ref().child(mediaPath).listAll();
      for (var image in images.items) {
        await image.delete();
      }
    } catch (e) {
      if (kDebugMode) {
        log('An error occurred while deleting product images: $e');
      }
      return false;
    }
    return true;
  }

  /// It deletes a product image from the Firebase Storage
  ///
  /// Args:
  ///   productId (String): The product id of the product whose image is to be deleted.
  ///   userId (String): The user id of the user who uploaded the image.
  ///   imageName (String): The name of the image to be deleted.
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> deleteProductImage({
    required String mediaPath,
    required String imageUrl,
  }) async {
    String imageName = imageUrl.split('/').last;
    try {
      await storage.ref().child('$mediaPath/$imageName').delete();
    } catch (e) {
      if (kDebugMode) {
        log('An error occurred while deleting product image: $e');
      }
      return false;
    }
    return true;
  }

  Map<String, bool> _selectedProducts = {};

  /// > This is the products map for items that are selected
  Map<String, bool> get selectedProducts => _selectedProducts;
  set selectedProducts(Map<String, bool> value) {
    _selectedProducts = value;
    notifyListeners();
  }

  void updateSelectedProducts(String key, bool value) {
    if (selectedProducts.containsKey(key)) {
      _selectedProducts.remove(key);
      notifyListeners();
      return;
    }
    _selectedProducts[key] = value;
    notifyListeners();
  }

  void clearselectedProducts() {
    _selectedProducts.clear();
    notifyListeners();
  }

  void clearSeleteddProducts(List<String> keys) {
    for (var key in keys) {
      _selectedProducts.remove(key);
    }
    notifyListeners();
  }

  void selectMultipledProducts(List<String> keys, bool value) {
    for (var key in keys) {
      _selectedProducts[key] = value;
    }
    notifyListeners();
  }

  Future<void> shareProuct(
      {required String productId, required BuildContext context}) async {
    final product = products[productId];
    if (product == null) {
      ShortMessages.showShortMessage(
          type: ShortMessageType.error,
          message: 'An error occurred, try again later !');
      return;
    }
    final link = await getProductLink(product: product, context: context);
    if (link == null) return;
    Dialogue.blurredDialogue(
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ShareQrCard(
            productUrl: link,
          ),
        ));
  }
}
