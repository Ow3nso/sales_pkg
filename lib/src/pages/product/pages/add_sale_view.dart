import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        CartController,
        CartIcon,
        DefaultBackButton,
        DefaultButton,
        DefaultInputField,
        HourGlass,
        LuhkuAppBar,
        NavigationService,
        Product,
        ReadContext,
        StyleColors,
        UserType,
        WatchContext;
import 'package:sales_pkg/src/pages/product/pages/add_product_view.dart';
import 'package:sales_pkg/src/pages/product/widgets/billing_card.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

import '../../../controllers/products_controller.dart';
import '../../../widgets/default_message.dart';
import '../widgets/sale_card.dart';

class AddSaleView extends StatelessWidget {
  const AddSaleView({super.key});

  static const routeName = 'add_sale';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: LuhkuAppBar(
        appBarType: AppBarType.other,
        color: StyleColors.lukhuBlue,
        backAction: DefaultBackButton(
          assetIcon: AppUtil.backButton,
          packageName: AppUtil.packageName,
        ),
        title: Text(
          'Add New Sale',
          style: TextStyle(
            color: StyleColors.lukhuWhite,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          CartIcon(
            userType: UserType.seller,
            color: StyleColors.lukhuWhite,
          )
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
              future: context.read<ProductController>().getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (context.watch<ProductController>().products.isEmpty) {
                    return Center(
                      child: DefaultMessage(
                        title: 'You don\'t have products yet',
                        assetImage: AppUtil.productIcon,
                        color: StyleColors.lukhuError10,
                        description:
                            'Add a product to your store by tapping the button below',
                        label: 'Add Products',
                        onTap: () {
                          NavigationService.navigate(
                              context, AddProductView.routeName);
                        },
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () => context
                        .read<ProductController>()
                        .getProducts(isrefreshMode: true),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 23, bottom: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: DefaultInputField(
                                  controller: context
                                      .watch<ProductController>()
                                      .searchController,
                                  prefix: Image.asset(
                                    AppUtil.searchIcon,
                                    package: AppUtil.packageName,
                                  ),
                                  onChange: (value) {
                                    context
                                        .read<ProductController>()
                                        .searchProduct();
                                  },
                                  hintText: "Search for products",
                                ),
                              ),
                              const SizedBox(width: 10),
                              DefaultButton(
                                label: 'Add Product',
                                width: 125,
                                height: 40,
                                onTap: () {
                                  NavigationService.navigate(
                                    context,
                                    AddProductView.routeName,
                                  );
                                },
                                color: StyleColors.lukhuBlue,
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SaleCard(
                              isAddedToCart: _addedToCart(context,
                                  _product(context, index)!.productId ?? ""),
                              data: _product(context, index)!.toJson(),
                              product: _product(context, index),
                            ),
                          ),
                          itemCount: context
                              .watch<ProductController>()
                              .products
                              .keys
                              .length,
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return DefaultMessage(
                    title: 'Error',
                    assetImage: AppUtil.productIcon,
                    color: StyleColors.lukhuError10,
                    description: snapshot.error.toString(),
                    label: 'Try Again',
                    onTap: () {
                      context.read<ProductController>().getProducts();
                    },
                  );
                }

                return const Center(
                  child: SizedBox(height: 40, width: 40, child: HourGlass()),
                );
              }),
        ),
      ),
      bottomSheet: _addSaleBottom(context),
    );
  }

  bool _addedToCart(BuildContext context, String id) =>
      context.watch<CartController>().isAddedToCart(id);

  BillingCard? _addSaleBottom(BuildContext context) {
    return View.of(context).viewInsets.bottom > 0
        ? null
        : context.watch<ProductController>().products.isNotEmpty
            ? const BillingCard()
            : null;
  }

  Product? _product(BuildContext context, int index) {
    return context
        .read<ProductController>()
        .products[_productKey(context, index)];
  }

  String _productKey(BuildContext context, int index) {
    return context.read<ProductController>().products.keys.elementAt(index);
  }
}
