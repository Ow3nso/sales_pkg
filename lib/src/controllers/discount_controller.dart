import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show ProductFields;
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class DiscountController extends ChangeNotifier {

  Map<String,bool> _selectedDiscounts = {};
  /// > This is the products map for items that are selected
  Map<String,bool> get selectedDiscounts => _selectedDiscounts;
  set selectedDiscounts(Map<String,bool> value) {
    _selectedDiscounts = value;
    notifyListeners();
  }
  void updateSelectedDiscounts(String key, bool value) {
    if(selectedDiscounts.containsKey(key)){
      _selectedDiscounts.remove(key);
      notifyListeners();
      return;
    }
    _selectedDiscounts[key] = value;
    notifyListeners();
  }

  void clearSelectedDiscounts() {
    _selectedDiscounts = {};
    notifyListeners();
  }

  void clearSeletedDiscounts(List<String> keys) {
    for (var key in keys) {
      _selectedDiscounts.remove(key);
    }
    notifyListeners();
  }

  void selectMultipleDiscounts(List<String> keys, bool value) {
    for (var key in keys) {
      _selectedDiscounts[key] = value;
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> discounts = AppUtil.discounts;

  void addDiscount(int index, [bool selectAll = false]) {
    if (selectAll) {
      for (var discount in discounts) {
        discount['isChecked'] = true;
      }
    } else {
      discounts[index]['isChecked'] = !discounts[index]['isChecked'];
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> discountOptions = [
    {
      'name': 'Percentage',
      'value': '',
      'options': ['0', '75'],
      'type': ProductFields.discountPercentage
    },
    {'name': 'Fixed Amount', 'value': '', 'type': ProductFields.discountAmount}
  ];

  bool get doesOptionValueExist =>
      discountOptions.any((element) => element['value'] != '');

  String? _discountOptionTitle;
  String? get discountOptionTitle => _discountOptionTitle;

  set discountOptionTitle(String? value) {
    _discountOptionTitle = value;
    notifyListeners();
  }


  double _sliderValue = 0;
  double get sliderValue => _sliderValue;
  set sliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  double _endDiscount = 15;
  double get endDiscount => _endDiscount;
  set endDiscount(double value) {
    _endDiscount = value;
    notifyListeners();
  }

  TextEditingController discountController = TextEditingController();

}
