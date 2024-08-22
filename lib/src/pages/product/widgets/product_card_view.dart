import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show NavigationService, Product, ReadContext, StyleColors, WatchContext;
import 'package:sales_pkg/src/controllers/products_controller.dart';
import 'package:sales_pkg/src/pages/product/pages/add_product_view.dart';
import 'package:sales_pkg/src/pages/product/pages/detail_view.dart';
import 'package:sales_pkg/src/widgets/default_message.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

import '../../../widgets/product_card.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: FutureBuilder(
          future: context.read<ProductController>().getProducts(),
          builder: (_, snapshot) {
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
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RefreshIndicator(
                  onRefresh: () => context
                      .read<ProductController>()
                      .getProducts(isrefreshMode: true),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.09,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 9,
                    ),
                    itemCount:
                        context.watch<ProductController>().products.keys.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        type: ProductType.product,
                        product: _product(context, index),
                        onTap: () {
                          NavigationService.navigate(
                              context, ProductDetailView.routeName, arguments: {
                            'productId': _product(context, index)!.productId
                          });
                          // context.read<DiscountController>().addDiscount(index);
                        },
                      );
                    },
                  ),
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
              child: CircularProgressIndicator(),
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
