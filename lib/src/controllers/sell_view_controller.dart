import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class SellViewController extends ChangeNotifier {
  List<String> durations = AppUtil.durations;
  Future<bool> getUserShop({bool isRefresh = false}) async {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context == null) return true;
    final userRepo = context.read<UserRepository>();
    if (userRepo.shop != null && !isRefresh) {
      return true;
    }
    await userRepo.getUserShop().catchError((e) {
      if (kDebugMode) {
        log("Error getting user shop: $e");
      }
      return;
    });
    return true;
  }

  String _selectedDuration = 'This Week';
  String get selectedDuration => _selectedDuration;

  set selectedDuration(String value) {
    _selectedDuration = value;
    notifyListeners();
  }

  String? _statDuration;
  String? get statDuration => _statDuration;
  set statDuration(String? value) {
    _statDuration = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> sellerStats = AppUtil.sellerStats;

  List<Map<String, dynamic>> sellerViewAction = AppUtil.sellerViewAction;

  List<Map<String, dynamic>> categories = AppUtil.categories;

  List<Map<String, dynamic>> resources = AppUtil.resources;
}
