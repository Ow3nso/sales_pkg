import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show ChangeNotifierProvider, SingleChildWidget, Provider;
import 'package:sales_pkg/src/controllers/add_item_controller.dart';
import 'package:sales_pkg/src/controllers/discount_controller.dart';
import 'package:sales_pkg/src/controllers/merchant_controller.dart';
import 'package:sales_pkg/src/controllers/sell_view_controller.dart';
import 'package:sales_pkg/src/pages/discount/discount_view.dart';
import 'package:sales_pkg/src/pages/discount/set_discount_view.dart';
import 'package:sales_pkg/src/pages/product/pages/add_sale_view.dart';
import 'package:sales_pkg/src/pages/product/pages/product_collection_view.dart';
import 'package:sales_pkg/src/pages/product/pages/product_view.dart';
import '../controllers/collection_controller.dart';
import '../controllers/customer_controller.dart';
import '../controllers/expense_controller.dart';
import '../controllers/order_controller.dart';
import '../controllers/products_controller.dart';
import '../controllers/service_controller.dart';
import '../controllers/sizes_selection_controller.dart';
import '../pages/customer/pages/add_customer_view.dart';
import '../pages/customer/pages/customer_view.dart';
import '../pages/order/orders_page.dart';
import '../pages/product/pages/add_product_view.dart';
import '../pages/product/pages/detail_view.dart';
import '../pages/product/widgets/collections/add_product_to_collection.dart';
import '../pages/resource/merchant_resource_view.dart';
import '../pages/resource/resource_detail.dart';
import '../pages/seller/seller_page.dart';
import '../pages/services/pages/all_expense.dart';
import '../pages/services/pages/expense.dart';
import '../pages/services/pages/request_delivery.dart';
import '../pages/services/pages/review_items.dart';
import '../pages/services/pages/services.dart';

class SalesRoutes {
  static Map<String, Widget Function(BuildContext)> guarded = {
    //  OrdersViewPage.routeName: (p0) => const OrdersViewPage(),
    // OrdersViewPage.routeName: (p0) => const OrdersViewPage(),
    DiscountView.routeName: (p0) => const DiscountView(),
    SetDiscountView.routeName: (p0) => const SetDiscountView(),
    ProductCollectionView.routeName: (p0) => const ProductCollectionView(),
    AddProductToColectionView.routeName: (p0) =>
        const AddProductToColectionView(),
    AddSaleView.routeName: (p0) => const AddSaleView(),
    AddProductView.routeName: (p0) => const AddProductView(),
    AddCustomer.routeName: (p0) => const AddCustomer(),
    CustomerView.routeName: (p0) => const CustomerView(),
    ProductDetailView.routeName: (p0) => const ProductDetailView(),
    MerchantResourceView.routeName: (p0) => const MerchantResourceView(),
    ResourceDetail.routeName: (p0) => const ResourceDetail(),
    ExpenseView.routeName: (p0) => const ExpenseView(),
    RequestDeliveryView.routeName: (po) => const RequestDeliveryView(),
    ReviewItems.routeName: (p0) => const ReviewItems(),
    AllExpense.routeName: (p0) => const AllExpense()
  };

  static Map<String, Widget Function(BuildContext)> public = {
    SellerPage.routeName: (p0) => const SellerPage(),
    OrdersViewPage.routeName: (p0) => const OrdersViewPage(),
    ProductView.routeName: (p0) => const ProductView(),
    ServicePage.routeName: (p0) => const ServicePage()
  };

  /// `listingProviders()` returns a list of widgets that are used to display the listings
  static List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider(
        create: (_) => SellViewController(),
      ),
      ChangeNotifierProvider(
        create: (_) => UploadProductController(),
      ),
      ChangeNotifierProvider(
        create: (context) => CustomerController(),
      ),
      ChangeNotifierProvider(
        create: (context) => DiscountController(),
      ),
      ChangeNotifierProvider(
        create: (context) => CollectionController(),
      ),
      ChangeNotifierProvider(
        create: (context) => MerchantController(),
      ),
      ChangeNotifierProvider(
        create: (context) => SizesSelectionController(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductController(),
      ),
      ChangeNotifierProvider(
        create: (context) => OrderController(),
      ),
      ChangeNotifierProvider(create: (_) => ServiceController()),
      ChangeNotifierProvider(create: (_) => ExpenseController()),
      Provider<BuildContext>(create: (c) => c),
    ];
  }
}
