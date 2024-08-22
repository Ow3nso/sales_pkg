import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show NavigationService, ReadContext;

import 'add_item_controller.dart';

class SizesSelectionController extends ChangeNotifier {
  final Map<String, Map<String, Map<String, List<String>>>> _sizesData = {};
  Map<String, Map<String, Map<String, List<String>>>> get sizesData =>
      _sizesData;
  void clearSizesData() {
    _sizesData.clear();
    notifyListeners();
  }
  void updateSelectedSizes(
      {required String category,
      required String categoryTitle,
      required String sizeLoCale,
      required String size}) {
    if (sizesData[category] == null) {
      _sizesData[category] = {
        categoryTitle: {sizeLoCale: []}
      };
    }

    if (sizesData[category]![categoryTitle] == null) {
      _sizesData[category]![categoryTitle] = {sizeLoCale: []};
    }

    if (sizesData[category]![categoryTitle]![sizeLoCale] == null) {
      _sizesData[category]![categoryTitle]![sizeLoCale] = [];
    }
    if (sizesData[category]?[categoryTitle]?[sizeLoCale]?.contains(size) ??
        false) {
      sizesData[category]?[categoryTitle]?[sizeLoCale]?.remove(size);
       _handleSizesListUpdate(sizeLoCale: sizeLoCale, size: size);
      notifyListeners();
      return;
    }

    sizesData[category]?[categoryTitle]?[sizeLoCale]?.add(size);
    notifyListeners();
    _handleSizesListUpdate(sizeLoCale: sizeLoCale, size: size);

    return;
  }

  bool isSizeSelected(
      {required String category,
      required String categoryTitle,
      required String sizeLoCale,
      required String size}) {
    return sizesData[category]?[categoryTitle]?[sizeLoCale]?.contains(size) ??
        false;
  }

  void _handleSizesListUpdate(
      {required String sizeLoCale, required String size}) {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;
    String s = '${sizeLoCale.split(' ').first} $size';
    context.read<UploadProductController>().updateSizes(s);
  }
}
