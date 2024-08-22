import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        CartController,
        DefaultBackButton,
        DefaultMessage,
        DefaultTextBtn,
        HourGlass,
        LuhkuAppBar,
        NavigationService,
        Product,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/sales_pkg.dart';
import 'package:sales_pkg/src/controllers/products_controller.dart';
import 'package:sales_pkg/src/pages/product/pages/add_product_view.dart';
import 'package:sales_pkg/src/pages/services/pages/review_items.dart';

import '../../../widgets/product_card.dart';

class RequestDeliveryView extends StatelessWidget {
  const RequestDeliveryView({super.key});
  static const routeName = 'request-delivery';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<CartController>().clearCart();
        return true;
      },
      child: Scaffold(
        appBar: LuhkuAppBar(
          appBarType: AppBarType.other,
          backAction: const DefaultBackButton(),
          enableShadow: true,
          color: Theme.of(context).colorScheme.onPrimary,
          title: Text(
            'Your Products',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: DefaultTextBtn(
                label: 'Add Product',
                onTap: () {
                  NavigationService.navigate(context, AddProductView.routeName);
                },
                underline: false,
              ),
            )
          ],
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
              future: context.read<ProductController>().getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (context.watch<ProductController>().products.isEmpty) {
                    return DefaultMessage(
                      color: StyleColors.lukhuError10,
                      title: 'You don’t have products yet',
                      description: 'Tap the button below to fetch products.',
                      onTap: () {
                        context.read<ProductController>().getProducts();
                      },
                      label: 'Refresh',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<ProductController>()
                          .getProducts(isrefreshMode: true);
                    },
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.09,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 9,
                      ),
                      itemCount: context
                          .watch<ProductController>()
                          .products
                          .keys
                          .length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          isSelected: context
                              .watch<CartController>()
                              .isAddedToCart(
                                  _product(context, index)?.productId ?? ''),
                          type: ProductType.selectable,
                          product: _product(context, index),
                          onTap: () {
                            context
                                .read<CartController>()
                                .addToCart(_product(context, index)!);
                          },
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return DefaultMessage(
                    color: StyleColors.lukhuError10,
                    title: 'An error occurred while fething product',
                    description: '${snapshot.error ?? ''}',
                    onTap: () {
                      context
                          .read<ProductController>()
                          .getProducts(isrefreshMode: true);
                    },
                    label: 'Refresh',
                  );
                }

                return const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: HourGlass(),
                  ),
                );
              },
            ),
          ),
        ),
        bottomSheet: context.watch<ProductController>().products.isEmpty
            ? null
            : BottomCard(
                label: 'Continue',
                onTap: context.watch<CartController>().cart.keys.isEmpty
                    ? null
                    : () {
                        NavigationService.navigate(
                          context,
                          ReviewItems.routeName,
                        );
                      },
              ),
      ),
    );
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
