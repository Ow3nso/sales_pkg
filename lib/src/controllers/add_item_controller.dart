import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppDBConstants,
        CameraDevice,
        FieldValue,
        FirebaseFirestore,
        FirebaseStorage,
        GlobalAppUtil,
        Helpers,
        ImagePicker,
        ImageSource,
        NavigationService,
        PathType,
        Product,
        ProductFields,
        ReadContext,
        Reference,
        SettableMetadata,
        ShortMessageType,
        ShortMessages,
        StorageUtils,
        UploadTask,
        UserRepository,
        Uuid,
        XFile,
        basename;
import 'package:sales_pkg/src/controllers/sizes_selection_controller.dart';
import 'package:sales_pkg/test_data/test_data.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

import '../pages/discount/widgets/set_discount_option.dart';

class UploadProductController extends ChangeNotifier {
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final maxMediaFiles = 4;
  String? _category;

  /// The category of the product.
  String? get category => _category;
  set category(String? value) {
    _category = value;
    notifyListeners();
  }

  String? _condition;

  /// The condition of the product.
  String? get condition => _condition;
  set condition(String? value) {
    _condition = value;
    notifyListeners();
  }

  bool _isVailableInVariousSizes = false;

  /// A variable that is used to determine if the product is available in various sizes.
  /// If it is true, then the user can select the size of the product.
  bool get isVailableInVariousSizes => _isVailableInVariousSizes;
  set isVailableInVariousSizes(bool value) {
    _isVailableInVariousSizes = value;
    notifyListeners();
  }

  double _sizePopUpHeight = 430;

  /// The height of the size pop up.
  double get sizePopUpHeight => _sizePopUpHeight;
  set sizePopUpHeight(double value) {
    _sizePopUpHeight = value;
    notifyListeners();
  }

  final List<String> _sizes = [];

  /// A list of sizes that the product is available in.
  /// This list is used to display the sizes in the size pop up.
  /// It is also used to display the sizes in the product details page.
  List<String> get sizes => _sizes;
  set sizes(List<String> value) {
    _sizes.clear();
    _sizes.addAll(value);
    notifyListeners();
  }

  void updateSizes(String size) {
    Set<String> sizesSet = _sizes.toSet();
    if (sizesSet.contains(size)) {
      sizesSet.remove(size);
      _sizes.remove(size);
      notifyListeners();
      return;
    }
    _sizes.add(size);
    notifyListeners();
  }

  /// A list of files that are picked from the gallery or camera.
  final List<String?> _pickedItemFiles = [...List.generate(4, (index) => null)];

  List<String?> get pickedItemFiles => _pickedItemFiles;
  set pickedItemFiles(List<String?> value) {
    _pickedItemFiles.clear();
    _pickedItemFiles.addAll(value);
    notifyListeners();
  }

  /// A variable that is used to determine if the app is uploading a file.
  bool _uploading = false;

  /// A variable that is used to determine if the app is uploading a file.
  bool get uploading => _uploading;
  set uploading(bool value) {
    _uploading = value;
    notifyListeners();
  }

  int _expansionTileKeys = 0;
  int get expansionTileKeys => _expansionTileKeys;
  set expansionTileKeys(int value) {
    _expansionTileKeys = value;
    notifyListeners();
  }

  /// It adds a new item to the products list.
  UploadProductController() {
    products.add({
      'id': '1',
      'name': 'Converse All Star High  Tops',
      'size': 'Various Sizes Available',
      'image':
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'quantity': 1,
      'price': '999',
      'views': 24,
      'liked': 20,
      'offers': 2,
      'sold': false,
      'discount': 0,
      'appliedDiscount': false,
      'collection': '',
      'isChecked': false,
    });
  }

  String _selectedCollection = '';
  String get selectedCollection => _selectedCollection;
  set selectedCollection(String value) {
    _selectedCollection = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> products = [];

  bool get hasProductsAvailable => products.isNotEmpty;

  /// It removes the file at the given index from the list of files
  ///
  /// Args:
  ///   index (int): The index of the file to be removed.
  void removeFile(int index) {
    _pickedItemFiles[index] = null;
    notifyListeners();
  }

  /// It takes a file and an index, and then it adds the file to the list of files at the index
  ///
  /// Args:
  ///   file (File): The file that was picked from the gallery.
  ///   index (int): the index of the item in the list
  void addPicture({required File file, required int index}) async {
    _pickedItemFiles[index] = file.path;
    notifyListeners();
  }

  /// It uploads the files to the server
  ///
  /// Args:
  ///   productId (String): The id of the product that the media is being uploaded to.
  ///
  /// Returns:
  ///   A list of futures.
  ///

  Future<void> uploadMedia(String productId) async {
    BuildContext? context =
        NavigationService.navigatorKey.currentState?.context;
    if (context == null) return;
    // only pass local files to the uploadFile method
    final localMediaFiles = pickedItemFiles
        .where((path) => Helpers.getPathType(path ?? '') != PathType.cloud)
        .toList();
    if (localMediaFiles.isNotEmpty) {
      try {
        await uploadFile(await Helpers.createHeroImage(localMediaFiles.first!),
            context, productId,
            isHero: true);
      } catch (e) {
        if (kDebugMode) {
          log("Error creating hero image: $e");
        }
      }
    }
    await Future.wait([
      ...localMediaFiles.map((filepath) => uploadFile(
          filepath == null ? null : File(filepath), context, productId)),
    ]).then((value) {
      resetMedia();
      clearProduct();
    });
  }

  void resetMedia() {
    pickedItemFiles = [null, null, null, null];
    notifyListeners();
  }

  /// > Uploads a file to Firebase Storage and updates the product's imageUrls list with the download URL
  ///
  /// Args:
  ///   file (File): The file to upload.
  ///   context (BuildContext): The BuildContext of the widget that calls this method.
  ///   productId (String): The product id of the product that the image is being uploaded for.
  ///
  /// Returns:
  ///   A Future<UploadTask?>
  Future<UploadTask?> uploadFile(

      /// The file to upload.
      File? file,

      /// The BuildContext of the widget that calls this method.
      BuildContext context,

      /// The product/doc id of the product that the image is being uploaded for.
      String docId,
      {
      /// If the file is the hero image, then this should be true.
      bool isHero = false,

      /// A callback that is called when the file is uploaded.
      Future<void> Function(String imageUrl)? callBack,

      /// The path to the storage folder where the file will be uploaded to.
      String? storagePath,

      /// A map of custom metadata to be added to the file.
      Map<String, String>? customMetadata}) async {
    if (file == null) {
      return null;
    }

    UploadTask uploadTask;

    final userRepo = context.read<UserRepository>();
    final userStorageDir = userRepo.user!.storageDir;
    var path = storagePath ??
        StorageUtils.getProductMediaFolder(
            productId: docId, userStorageDir: userStorageDir!);
    String urlpath = '$path/${basename(file.path)}';
    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref(urlpath);

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {
        if (customMetadata != null) ...customMetadata,
        'productId': docId,
        'uploader': context.read<UserRepository>().user!.userId ?? "",
      },
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(File(file.path), metadata);
    }

    await uploadTask.whenComplete(() async {
      final imageUrl = await _getDownloadLink(ref);
      if (callBack != null) {
        await callBack(imageUrl);
      } else {
        await _updateProductImageUrls(docId, imageUrl, isHero: isHero);
      }
    });

    return Future.value(uploadTask);
  }

  /// It takes a reference to a file in the Firebase Storage and returns a download link to that file
  ///
  /// Args:
  ///   ref (Reference): The reference to the file you want to download.
  ///
  /// Returns:
  ///   A Future<String>
  Future<String> _getDownloadLink(Reference ref) async {
    final link = await ref.getDownloadURL();
    return link;
  }

  /// It updates the product document with the image url.
  ///
  /// Args:
  ///   productId (String): The id of the product to which the image belongs.
  ///   imageUrl (String): The URL of the image that was uploaded to Firebase Storage.
  ///
  /// Returns:
  ///   A Future<void>
  Future<void> _updateProductImageUrls(String productId, String imageUrl,
      {bool isHero = false}) {
    return db
        .collection(AppDBConstants.productsCollection)
        .doc(productId)
        .update({
      if (!isHero) ProductFields.images: FieldValue.arrayUnion([imageUrl]),
      if (isHero) ProductFields.heroImage: imageUrl,
    });
  }

  /// It allows the user to pick an image or video from the gallery or camera, and returns the picked
  /// file as a `File` object
  ///
  /// Args:
  ///   allowCamera (bool): If true, the user will be able to take a picture or video with the camera.
  /// Defaults to false
  ///   letUserPickVideo (bool): If true, the user will be able to pick a video. If false, the user will
  /// be able to pick an image. Defaults to false
  ///   useCameraFront (bool): If true, the camera will be opened in front camera mode. Defaults to
  /// false
  ///   duration (Duration): The maximum duration of the video.
  ///
  /// Returns:
  ///   A Future<File?>
  Future<File?> pickVideoOrImage({
    bool allowCamera = false,
    bool letUserPickVideo = false,
    bool useCameraFront = false,
    Duration? duration,
  }) async {
    File? pickedImageOrVideo;
    XFile? pickedFile;
    if (letUserPickVideo) {
      pickedFile = await ImagePicker().pickVideo(
        source: allowCamera ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice:
            useCameraFront ? CameraDevice.front : CameraDevice.rear,
        maxDuration: duration,
      );
    } else {
      pickedFile = await ImagePicker().pickImage(
        source: allowCamera ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice:
            useCameraFront ? CameraDevice.front : CameraDevice.rear,
      );
    }

    if (pickedFile != null) {
      pickedImageOrVideo = File(pickedFile.path);
    }

    return pickedImageOrVideo;
  }

  String userImageAvatar = TestData.userAVatar;

  bool _chooseAnyColor = false;
  bool get chooseAnyColor => _chooseAnyColor;

  set chooseAnyColor(bool value) {
    _chooseAnyColor = value;
    notifyListeners();
  }

  /// It takes a key and a value, finds the key in the list of products, and updates the value of that
  /// key
  ///
  /// Args:
  ///   key (String): The key of the filter you want to update.
  ///   data (String): The data that is being passed from the child widget.
  void updateFilterValues(String key, String? data) {
    productInfo.firstWhere((value) => value['name'] == key)['value'] =
        data ?? '';

    notifyListeners();
  }

  bool isColorValueSame(String key, String value) {
    return productInfo.any((data) => data['name'] == value);
  }

  String _selectedFilterColor = '';
  String get selectedFilterColor => _selectedFilterColor;

  set selectedFilterColor(String value) {
    _selectedFilterColor = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> tips = AppUtil.tips;

  List<Map<String, dynamic>> filterColors = TestData.filterColors;

  /// A list of maps.(Products)
  List<Map<String, dynamic>> productInfo = GlobalAppUtil.productInfo;

  List<Map<String, dynamic>> productManageOptions =
      TestData.productManageOptions;

  //Controller
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();

  Map<String, String> postData = {};

  String _selectedColor = 'Black';
  String get selectedColor => _selectedColor;
  set selectedColor(String value) {
    _selectedColor = value;
    notifyListeners();
  }

  Map<String, dynamic> get selectedFilteredColor => filterColors.first;

  String get selectedSize => 'Sizes';

  Product? _product;

  /// A getter and setter for the product.
  Product? get product => _product;
  set product(Product? value) {
    _product = value;
    notifyListeners();
  }

  /// `clearProduct()` sets the `product` variable to `null`
  void clearProduct() {
    product = null;
    productNameController.clear();
    productDescriptionController.clear();
    productQuantityController.clear();
    productPriceController.clear();
    productDiscountController.clear();
    category = null;
    condition = null;
    sizes.clear();
    selectedColors.clear();
    pickedItemFiles.clear();
    lastProductDocId = null;
    NavigationService.navigatorKey.currentContext
        ?.read<SizesSelectionController>()
        .clearSizesData();
    notifyListeners();
  }

  String? _lastProductDocId;
  String? get lastProductDocId => _lastProductDocId;
  set lastProductDocId(String? value) {
    _lastProductDocId = value;
    notifyListeners();
  }

  /// `initProduct()` initializes the `product` variable with a new `Product` object with a new
  /// `productId` and the `sellerId` of the current user
  Future<bool> initProduct({Product? originalProduct}) async {
    if (originalProduct != null) {
      return updateProduct(originalProduct);
    }
    uploading = true;
    BuildContext context = NavigationService.navigatorKey.currentState!.context;
    final userRepo = context.read<UserRepository>();
    final userStorageDir = userRepo.user!.storageDir;
    if (userRepo.shop?.shopId == null) {
      uploading = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please create a shop before adding a product')));
      return false;
    }
    final productId = const Uuid().v4();
    lastProductDocId = productId;
    var mediaPath = StorageUtils.getProductMediaFolder(
        productId: productId, userStorageDir: userStorageDir!);
    product = Product.empty();
    product = product!.copyWith(
        productId: productId,
        sellerId: context.read<UserRepository>().user!.userId,
        lastUpdatedAt: DateTime.now().millisecondsSinceEpoch,
        label: productNameController.text.trim(),
        description: productDescriptionController.text.trim(),
        price: double.parse(productPriceController.text.trim()),
        availableSizes: isVailableInVariousSizes ? ['Various sizes'] : sizes,
        stock: int.parse(productQuantityController.text.trim()),
        category: category,
        subCategory: condition,
        mediaPath: mediaPath,
        shopId: userRepo.shop?.shopId,
        availableColors: [...selectedColors.toList()]);

    final productData = product!.toJson();
    if (!isProductDataValid(data: productData)) {
      uploading = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid product data all the required')));
      if (kDebugMode) {
        log('Invalid product data all the required fields are not set, required fields are: $requiredProductFields');
      }
      return false;
    }
    product = Product.fromJson(productData);
    return saveProduct();
  }

  /// > It saves the product to the database and uploads the media to the storage
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> saveProduct() async {
    if (product == null) return false;
    try {
      final productRef = db
          .collection(AppDBConstants.productsCollection)
          .doc(product!.productId);

      await productRef.set(product!.toJson());
      await uploadMedia(product!.productId!);
    } catch (e) {
      uploading = false;
      if (kDebugMode) {
        log('Error saving product', error: e);
      }
      return false;
    }
    uploading = false;

    return true;
  }

  /// A list of all the required fields for a product.
  final List<String> requiredProductFields = [
    ProductFields.label,
    ProductFields.description,
    ProductFields.price,
    ProductFields.category,
    ProductFields.subCategory,
    ProductFields.stock,
    ProductFields.availableColors,
    ProductFields.availableSizes,
    ProductFields.mediaPath,
  ];

  //https://firebasestorage.googleapis.com/v0/b/lukhu-dev.appspot.com/o/user_images%2FA9CWIddd9Vavmmo361Hp2vM5wnG3?alt=media&token=1b34d375-c757-48e1-bc83-9b48535cb4ea

  /// If any of the required fields are null or empty, return false. Otherwise, return true
  ///
  /// Args:
  ///   data (Map<String, dynamic>): The data that you want to validate.
  ///
  /// Returns:
  ///   A boolean value.
  bool isProductDataValid({required Map<String, dynamic> data}) {
    for (final field in requiredProductFields) {
      if (data[field] == null || data[field] == '') {
        return false;
      }
    }
    return true;
  }

  bool _allowDiscount = false;
  bool get allowDiscount => _allowDiscount;

  /// A setter method.
  set allowDiscount(bool value) {
    _allowDiscount = value;
    notifyListeners();
  }

  bool _markAsSold = false;
  bool get markAsSold => _markAsSold;
  set markAsSold(bool value) {
    _markAsSold = value;

    productManageOptions.firstWhere(
        (data) => data['name'] == selectedKey)['value'] = value ? 'Sold' : '';
    if (_deleteId.isNotEmpty) {
      products.firstWhere((data) => data['id'] == _deleteId)['sold'] = value;
    }
    notifyListeners();
  }

  /// If the text is not empty, then set the value of the productManageOptions list to the text
  ///
  /// Args:
  ///   key (String): The key of the product option.
  void setDiscount(String value, DiscountType type) {
    if (_deleteId.isNotEmpty) {
      var addedDiscount = '';
      if (type == DiscountType.fixedAmount) {
        addedDiscount = 'KES $value Off';
      } else {
        addedDiscount = '$value% Off';
      }

      var product = products.firstWhere((data) => data['id'] == _deleteId);
      product['discount'] = addedDiscount;
      product['appliedDiscount'] = true;
      productManageOptions.firstWhere(
          (data) => data['name'] == 'Set a discount')['value'] = addedDiscount;
    }

    notifyListeners();
  }

  String _selectedKey = '';
  String get selectedKey => _selectedKey;
  set selectedKey(String value) {
    _selectedKey = value;

    notifyListeners();
  }

  Set<String> selectedColors = {};
  void updateSelectedColors(String color) {
    if (selectedColors.contains(color)) {
      selectedColors.remove(color);
    } else {
      selectedColors.add(color);
    }
    notifyListeners();
  }

  String _deleteId = '';
  String get deleteId => _deleteId;
  set deleteId(String value) {
    _deleteId = value;
    notifyListeners();
  }

  void deleteProduct() {
    if (products.any((data) => data['id'] == deleteId)) {
      var product = products.indexWhere((data) => data['id'] == deleteId);
      products.removeAt(product);
      deleteId = '';
    }

    notifyListeners();
  }

  /// A method that initializes the values of the product from the existing product.
  void initalizeValuesFromExistingProduct(Product product) {
    productNameController.text = product.label!;
    productDescriptionController.text = product.description!;
    productPriceController.text = product.price.toString();
    productQuantityController.text = product.stock.toString();
    category = product.category!;
    condition = product.subCategory!;
    selectedColors = product.availableColors!.toSet();
    sizes = product.availableSizes!;
    pickedItemFiles = product.images ?? [];
    // if there are less than max images, add null to the list to make it max value
    if (pickedItemFiles.length < maxMediaFiles) {
      pickedItemFiles = [
        ...pickedItemFiles,
        ...List.generate(
            maxMediaFiles - pickedItemFiles.length, (index) => null)
      ];
    }
    notifyListeners();
  }

  // A  method that updates an existing product

  Future<bool> updateProduct(Product product) async {
    uploading = true;
    product = product.copyWith(
        lastUpdatedAt: DateTime.now().millisecondsSinceEpoch,
        label: productNameController.text.trim(),
        description: productDescriptionController.text.trim(),
        price: double.parse(productPriceController.text.trim()),
        availableSizes: sizes,
        stock: int.parse(productQuantityController.text.trim()),
        category: category,
        subCategory: condition,
        images: [..._getUpdatedMediaPaths()],
        availableColors: [...selectedColors.toList()]);

    final productData = product.toJson();
    if (!isProductDataValid(data: productData)) {
      uploading = false;
      ShortMessages.showShortMessage(
          message: 'Invalid product data all the required',
          type: ShortMessageType.warning);
      if (kDebugMode) {
        log('Invalid product data all the required fields are not set, required fields are: $requiredProductFields');
      }
      return false;
    }
    product = Product.fromJson(productData);
    return updateProductInDatabase(product);
  }

  /// > It updates the product in the database and uploads the media to the storage
  /// Returns:
  ///  A Future<bool>
  /// Throws:
  /// A [FirebaseException] if there is an error updating the product in the database
  /// A [FirebaseException] if there is an error uploading the media to the storage

  Future<bool> updateProductInDatabase(Product product) async {
    try {
      final productRef = db
          .collection(AppDBConstants.productsCollection)
          .doc(product.productId);

      await productRef.update(product.toJson());
      await uploadMedia(product.productId!);
    } catch (e) {
      uploading = false;
      if (kDebugMode) {
        log('Error saving product', error: e);
      }
      return false;
    }
    uploading = false;

    return true;
  }

  // A method that filters the media paths that are not null and are not local paths
  List<String> _getUpdatedMediaPaths() {
    final updatedMediaPaths = <String>[];
    for (final mediaPath in pickedItemFiles) {
      if (mediaPath != null) {
        if (Helpers.getPathType(mediaPath) == PathType.cloud) {
          updatedMediaPaths.add(mediaPath);
        }
      }
    }
    return updatedMediaPaths;
  }
}
