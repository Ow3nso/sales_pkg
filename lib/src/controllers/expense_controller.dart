import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppDBConstants,
        Expense,
        ExpenseCategory,
        ExpenseFields,
        FirebaseFirestore,
        Helpers,
        NavigationService,
        ReadContext,
        UserRepository,
        Uuid;

class ExpenseController extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late GlobalKey<FormState> addExpenseFormKey;

  ExpenseController() {
    init();
  }

  TextEditingController get nameController => _nameController;
  TextEditingController get amountController => _amountController;
  TextEditingController get noteController => _noteController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get dateController => _dateController;

  void init() {
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    expense = Expense.empty();
    addExpenseFormKey = GlobalKey();
    isLoading = false;
  }

  late Expense? _expense;
  Expense? get expense => _expense;
  set expense(Expense? value) {
    _expense = value;
    notifyListeners();
  }

  Map<String, Expense> _expenses = {};
  Map<String, Expense> get expenses => _expenses;
  set expenses(Map<String, Expense> value) {
    _expenses = value;
    notifyListeners();
  }

  Map<String, Map<String, Expense>> similarExpenses = {};

  Future<bool> getShopExpenses({
    bool isRefreshMode = false,
  }) async {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context == null) return false;
    var shopId = context.read<UserRepository>().shop?.shopId;
    if (similarExpenses[shopId] != null && !isRefreshMode) return false;
    try {
      final expenseDoc = await db
          .collection(AppDBConstants.expenseCollection)
          .where(ExpenseFields.shopId, isEqualTo: shopId)
          .get();

      if (expenseDoc.docs.isNotEmpty) {
        expenses = {
          for (var e in expenseDoc.docs) e.id: Expense.fromJson(e.data())
        };
        similarExpenses[shopId!] = expenses;
        return true;
      }
    } catch (e) {
      Helpers.debugLog('An error occurred while fetching expenses: $e');
      return false;
    }
    return false;
  }

  ExpenseCategory? _category;
  ExpenseCategory? get category => _category;
  set category(ExpenseCategory? value) {
    _category = value;
    notifyListeners();
  }

  DateTimeRange? _range;
  DateTimeRange? get range => _range;
  set range(DateTimeRange? value) {
    _range = value;
    notifyListeners();
  }

  String get selectedCategory => category == null
      ? "All Categories"
      : ExpenseCategory.values[category?.index ?? 0].name;

  Future<bool> addExpense({
    Expense? originalExpense,
  }) async {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context == null) return false;
    if (originalExpense != null) {
      return updateExpense(originalExpense);
    }
    expense = Expense.empty();
    expense = expense!.copyWith(
      id: const Uuid().v4(),
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      amount: amountController.text.isEmpty
          ? 0
          : double.parse(amountController.text.trim()),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      shopId: context.read<UserRepository>().shop?.shopId,
      userId: context.read<UserRepository>().fbUser?.uid,
      note: noteController.text.trim(),
      category: category ?? ExpenseCategory.other,
      fromdate: range?.start ?? DateTime.now(),
      toDate: range?.end ?? DateTime.now(),
    );

    final jsonData = expense!.toJson();
    Helpers.debugLog('[EXPENSE]: $jsonData');
    if (!verifyExpenseData(jsonData)) {
      return false;
    }
    expense = Expense.fromJson(jsonData);
    try {
      final expenseRef = db.collection(AppDBConstants.expenseCollection);
      await expenseRef.doc(expense!.id).set(expense!.toJson());
      return true;
    } catch (e) {
      Helpers.debugLog('An error occurred while adding expense: $e');
      return false;
    }
  }

  Future<bool> updateExpense(Expense value) async {
    if (expense?.id == null) return false;
    if (!checkIfDataChanged(expense!.toJson(), value.toJson())) return false;
    try {
      final expenseRef =
          db.collection(AppDBConstants.expenseCollection).doc(value.id);
      expenseRef.update(value.toJson());
      return true;
    } catch (e) {
      Helpers.debugLog('An error occurred while updating');
      return false;
    }
  }

  bool checkIfDataChanged(Map map1, Map map2) {
    // Check if the number of entries in both maps is the same
    if (map1.length != map2.length) {
      return false;
    }

    // Compare the values for each key in map1
    for (var key in map1.keys) {
      if (map1[key] != map2[key]) {
        return false;
      }
    }

    // If all values are the same, return true
    return true;
  }

  final List<String> requiredFields = [
    ExpenseFields.amount,
    ExpenseFields.name,
    ExpenseFields.shopId,
    ExpenseFields.fromDate,
    ExpenseFields.toDate,
  ];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool verifyExpenseData(Map<String, dynamic> value) {
    for (var data in requiredFields) {
      if (value[data] == null || value[data] == "") {
        Helpers.debugLog('An error occurred, field: $data is missing');
        return false;
      }
    }
    return true;
  }
}
