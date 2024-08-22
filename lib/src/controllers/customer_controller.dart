import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppDBConstants,
        Customer,
        CustomerFields,
        FirebaseFirestore,
        Gender,
        Helpers,
        LocationController,
        NavigationService,
        ShortMessages,
        StringExtension,
        Uuid,
        ReadContext;
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class CustomerController extends ChangeNotifier {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController userNameController;
  late TextEditingController dobController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;
  late TextEditingController buildingController;

  final db = FirebaseFirestore.instance;
  late GlobalKey<FormState> formKey;

  Map<String, Customer> _customers = {};
  Map<String, Customer> get customers => _customers;
  set customers(Map<String, Customer> value) {
    _customers = value;
    notifyListeners();
  }

  List<Gender> customerGender = Gender.values;

  Map<String, Map<String, Customer>> similarCustomers = {};

  CustomerController() {
    init();
  }

  void clear() {}

  var genderLabel = {
    "Female": Gender.female,
    "Male": Gender.male,
    "Other": Gender.other,
    "None": Gender.none
  };

  void init() async {
    buildingController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    userNameController = TextEditingController();
    dobController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    formKey = GlobalKey();
  }

  Gender? _gender;
  Gender? get gender => _gender;
  set gender(Gender? value) {
    gender = value;
    Helpers.debugLog('set gender: $value');
    if (value != null) {
      Helpers.debugLog('set gender: ${genderLabel[value]}');
    }
    notifyListeners();
  }

  // List<Map<String, dynamic>> customers = [];

  /// If the customer doesn't exist, add them to the list
  ///
  /// Args:
  ///   data (Map<String, dynamic>): This is the data that you want to add to the list.
  // void addCustomer(Map<String, dynamic> data) {
  //   bool exists = customers.any((value) => value['phone'] == data['phone']);
  //   if (!exists) {
  //     customers.add(data);
  //   }
  //   notifyListeners();
  // }

  Customer? _customer;
  Customer? get customer => _customer;
  set customer(Customer? value) {
    if (value != null) {
      resetCustomer();
    }
    _customer = value;
    notifyListeners();
  }

  void resetCustomer() {
    for (var id in customers.keys) {
      customers[id] = customers[id]!.copyWith(status: false);
    }
    notifyListeners();
  }

  bool _uploading = false;
  bool get uploading => _uploading;
  set uploading(bool value) {
    _uploading = value;
    notifyListeners();
  }

  String? _shopId;
  String? get shopId => _shopId;
  set shopId(String? value) {
    _shopId = value;
    notifyListeners();
  }

  DateTime? _dob;
  DateTime? get dob => _dob;
  set dob(DateTime? value) {
    _dob = value;
    notifyListeners();
  }

  String? _selectedGender;
  String? get selectedGender => _selectedGender;
  set selectedGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  Future<bool> addCustomer() async {
    if (!formKey.currentState!.validate()) return false;
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context == null) return false;
    var location = context.read<LocationController>().location;
    if (location == null) {
      ShortMessages.showShortMessage(
        message: "Customer address is missing!.",
      );
      return false;
    }
    final id = const Uuid().v4();
    uploading = true;
    customer = Customer.empty();
    customer = customer!.copyWith(
      customerId: id,
      gender: genderLabel[selectedGender],
      name: nameController.text,
      shopId: shopId,
      createdAt: DateTime.now(),
      address: location,
      dob: _dob,
      updatedAt: DateTime.now(),
      userName: userNameController.text,
      phoneNumber: phoneController.text.trim().toLukhuNumber(),
      description: descriptionController.text,
    );

    try {
      final data = customer!.toJson();
      if (!isCustomerDataValid(value: data)) {
        uploading = false;
        ShortMessages.showShortMessage(
            message: "Please ensure you provide valid customer details.");
        return false;
      }
      customer = Customer.fromJson(data);

      return uploadCustomer();
    } catch (e) {
      Helpers.debugLog('[Adding Customer Err]${e.toString()}');
      uploading = false;
      ShortMessages.showShortMessage(
        message:
            "Something happened while adding your customer. Please try again",
      );
    }

    return false;
  }

  Future<bool> uploadCustomer() async {
    try {
      final insertRef =
          db.collection(AppDBConstants.customers).doc(customer!.customerId!);
      await insertRef.set(customer!.toJson());
      uploading = false;
      return true;
    } catch (e) {
      uploading = false;
      ShortMessages.showShortMessage(
        message: "Something went wrong",
      );
    }
    return false;
  }

  Future<bool> getStoreCustomers({
    bool isRefreshMode = false,
    int limit = 5,
  }) async {
    if (similarCustomers[shopId] != null && !isRefreshMode) {
      return true;
    }

    try {
      var storeCustomers = await db
          .collection(AppDBConstants.customers)
          .where(CustomerFields.shopId, isEqualTo: shopId)
          .limit(limit)
          .get();

      if (storeCustomers.docs.isNotEmpty) {
        customers = {
          for (var e in storeCustomers.docs) e.id: Customer.fromJson(e.data())
        };
        similarCustomers[shopId!] = customers;
        return true;
      }
    } catch (e) {
      Helpers.debugLog('An error occurred while getting customers: $e');
    }

    return false;
  }

  final List<String> requiredCustomerDetails = [
    CustomerFields.name,
    CustomerFields.phoneNumber,
    CustomerFields.gender,
  ];

  bool isCustomerDataValid({required Map<String, dynamic> value}) {
    for (final field in requiredCustomerDetails) {
      if (value[field] == null || value[field] == "") {
        Helpers.debugLog('MISSING VALUE:$field ${value[field]}');
        return false;
      }
    }
    return true;
  }

  List<Map<String, dynamic>> get addressCategory => AppUtil.addresCategory;

  void toggleAddress([int index = -1]) {
    for (var address in addressCategory) {
      address['isSelected'] = false;
    }

    if (index == -1) {
      addressController = TextEditingController();
      buildingController = TextEditingController();
      selectedAddress = {};
      notifyListeners();
      return;
    }

    addressCategory[index]['isSelected'] = true;
    selectedAddress = addressCategory[index];

    notifyListeners();
  }

  Map<String, dynamic> _selectedAddress = {};
  Map<String, dynamic> get selectedAddress => _selectedAddress;
  set selectedAddress(Map<String, dynamic> value) {
    _selectedAddress = value;
    notifyListeners();
  }
}
