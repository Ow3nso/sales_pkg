import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        ConfirmationCard,
        DefaultBackButton,
        DefaultTextBtn,
        LuhkuAppBar,
        NavigationService,
        ReadContext,
        ShopCollection,
        StyleColors,
        WatchContext;

import '../../../../controllers/collection_controller.dart';
import '../../../../controllers/products_controller.dart';
import '../../../../widgets/bottom_card.dart';
import '../../../../widgets/default_message.dart';
import '../../../../widgets/dialogue.dart';
import '../../../../widgets/product_card.dart';
import '../../pages/add_product_view.dart';

class AddProductToColectionView extends StatelessWidget {
  const AddProductToColectionView({super.key});
  static const routeName = 'add_product_to_collection';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var collection =
        ModalRoute.of(context)!.settings.arguments as ShopCollection;
    var products = context
        .watch<ProductController>()
        .products
        .entries
        .where((element) =>
            !(collection.productIds!.contains(element.value.productId!)))
        .toList();
    return Scaffold(
      appBar: LuhkuAppBar(
        enableShadow: true,
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        title: Text(
          'Add products to ${collection.name}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          if (products.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: DefaultTextBtn(
                onTap: () {
                  if (context
                          .read<ProductController>()
                          .selectedProducts
                          .length ==
                      products.length) {
                    context.read<ProductController>().clearselectedProducts();
                    return;
                  }
                  context.read<ProductController>().selectMultipledProducts(
                      products.map((e) => e.key).toList(), false);
                },
                child: Text(
                  context.watch<ProductController>().selectedProducts.length ==
                          products.length
                      ? 'Unselect'
                      : 'Select All',
                  style: TextStyle(
                    color: StyleColors.lukhuBlue,
                  ),
                ),
              ),
            )
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: products.isEmpty
              ? DefaultMessage(
                  color: StyleColors.lukhuError10,
                  title: 'No Products to add',
                  description:
                      'Seems like all you products are part of ${collection.name} or you have no products, add more products to set include in this collection',
                  onTap: () {
                    NavigationService.navigate(
                        context, AddProductView.routeName);
                  },
                  label: 'Add Products',
                )
              : ListView(
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
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: products[index].value,
                        type: ProductType.selectable,
                        isSelected: context
                            .watch<ProductController>()
                            .selectedProducts
                            .containsKey(products[index].value.productId),
                        onTap: () {
                          context
                              .read<ProductController>()
                              .updateSelectedProducts(
                                  products[index].value.productId!, false);
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
      bottomSheet: products.isEmpty
          ? null
          : BottomCard(
              label: 'Add to Collection',
              onTap: context.watch<ProductController>().selectedProducts.isEmpty
                  ? null
                  : () {
                      Dialogue.blurredDialogue(
                        distance: 0,
                        context: context,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ConfirmationCard(
                              onSecondaryTap: () {
                                Navigator.of(context).pop();
                              },
                              onPrimaryTap: () {
                                context
                                    .read<CollectionController>()
                                    .addProductsToCollection(
                                      productIds: context
                                            .read<ProductController>()
                                            .selectedProducts.keys.toList(),
                                      collectionId: collection.docId!,
                                        );
                                Navigator.of(context).pop();
                                 Navigator.of(context).pop();
                              },
                              title: "Add Products to collection",
                              description:
                                  "You have selected ${context.read<ProductController>().selectedProducts.length}",
                              height: 300,
                              primaryLabel: 'Confirm',
                              secondaryLabel: "Cancell"),
                        ),
                      );
                    }),
    );
  }
}
