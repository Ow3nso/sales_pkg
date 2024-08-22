import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show AppBarType, DefaultBackButton, LuhkuAppBar, NavigationService, Product, ReadContext, ShopCollection, StyleColors;
import 'package:sales_pkg/src/controllers/products_controller.dart';

import '../../../utils/styles/app_util.dart';
import '../../../widgets/bottom_card.dart';
import '../../../widgets/default_message.dart';
import '../../../widgets/product_card.dart';
import '../widgets/collections/add_product_to_collection.dart';
import 'detail_view.dart';

class ProductCollectionView extends StatelessWidget {
  const ProductCollectionView({super.key});
  static const routeName = 'collections_view';

  @override
  Widget build(BuildContext context) {
    var collection =
        ModalRoute.of(context)!.settings.arguments as ShopCollection;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: LuhkuAppBar(
        backAction: const DefaultBackButton(),
        appBarType: AppBarType.other,
        title: Text(
          collection.name ?? '',
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
            height: size.height,
            width: size.width,
            child: collection.productIds!.isNotEmpty
                ? ListView(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.09,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 9,
                        ),
                        itemCount: collection.productIds!.length,
                        itemBuilder: (context, index) => ProductCard(
                          product: _product(context, collection, index),
                          type: ProductType.selectable,
                          onLongPress: () {},
                          onTap: () {
                            NavigationService.navigate(
                                context, ProductDetailView.routeName,
                                arguments: {
                                  'productId':
                                      _product(context, collection, index)!
                                          .productId
                                });
                          },
                        ),
                      ),
                    ],
                  )
                : DefaultMessage(
                    title: 'This collection is empty',
                    assetImage: AppUtil.folderOpenIcon,
                    color: StyleColors.lukhuError10,
                    description:
                        'Add a product to this collection by tapping the button below',
                    label: 'Add Products',
                    onTap: () {
                      NavigationService.navigate(
                          context, AddProductToColectionView.routeName,
                          arguments: collection);
                    })),
      ),
      bottomSheet:collection.productIds!.isEmpty ?null :BottomCard(
              label: 'Add Products',
              onTap: () {
                    NavigationService.navigate(
                    context, AddProductToColectionView.routeName,
                    arguments: collection);
                    }
                 
            ),
    );
  }

  Product? _product(
          BuildContext context, ShopCollection collection, int index) =>
      context.read<ProductController>().products[collection.productIds![index]];
}
