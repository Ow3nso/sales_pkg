import 'package:flutter/material.dart';

import '../utils/styles/app_util.dart';

class MerchantController extends ChangeNotifier {
  List<Map<String, dynamic>> resources = AppUtil.resources;

  bool _showBackButton = true;
  bool get showBackButton => _showBackButton;
  set showBackButton(bool value) {
    _showBackButton = value;
    notifyListeners();
  }
}
