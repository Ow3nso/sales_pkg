import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show AppDBConstants, FirebaseFirestore, Helpers, OrderFields, OrderModel;

class OrderController extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  bool _showItemsSold = false;
  bool get showItemsSold => _showItemsSold;
  set showItemsSold(bool value) {
    _showItemsSold = value;
    notifyListeners();
  }

  bool _showItemsBought = false;
  bool get showItemsBought => _showItemsBought;
  set showItemsBought(bool value) {
    _showItemsBought = value;
    notifyListeners();
  }

  Map<String, OrderModel> _orders = {};
  Map<String, OrderModel> get orders => _orders;
  set orders(Map<String, OrderModel> value) {
    _orders = value;
    notifyListeners();
  }

  String? _shopId;
  String? get shopId => _shopId;

  Map<String, Map<String, OrderModel>> similarOrders = {};

  Future<bool> getOrders({
    bool isRefreshMode = false,
    int limit = 10,
  }) async {
    if (!isRefreshMode && similarOrders[shopId] != null) return false;
    try {
      var orderDocs = await db
          .collection(AppDBConstants.orderCollection)
          .where(OrderFields.shopId, isEqualTo: shopId)
          .limit(limit)
          .get();

      if (orderDocs.docs.isNotEmpty) {
        orders = {
          for (var e in orderDocs.docs) e.id: OrderModel.fromJson(e.data())
        };
        similarOrders[shopId!] = orders;
        return true;
      }
    } catch (e) {
      Helpers.debugLog('An error occurred while fetching orders: $e');
    }
    return false;
  }

  String _orderKey(int index, Map<String, OrderModel> value) {
    return value.keys.elementAt(index);
  }

  OrderModel? order(int index, Map<String, OrderModel> value) {
    return value[_orderKey(index, value)];
  }
}
