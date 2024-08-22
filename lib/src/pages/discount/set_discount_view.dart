import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        DefaultBackButton,
        DefaultTextBtn,
        LuhkuAppBar,
        NavigationService,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/discount_controller.dart';
import 'package:sales_pkg/src/pages/discount/widgets/discount_options.dart';
import 'package:sales_pkg/src/widgets/bottom_card.dart';
import 'package:sales_pkg/src/widgets/dialogue.dart';

import '../../controllers/products_controller.dart';
import '../../widgets/default_message.dart';
import '../../widgets/product_card.dart';
import '../product/pages/add_product_view.dart';

class SetDiscountView extends StatelessWidget {
  const SetDiscountView({super.key});
  static const routeName = 'set_discount';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var discounts = context
        .watch<ProductController>()
        .products
        .entries
        .where((element) => !(element.value.isOnDiscount ?? true))
        .toList();
    return Scaffold(
      appBar: LuhkuAppBar(
        enableShadow: true,
        height: 85,
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        color: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Set Discount',
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          if (discounts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: DefaultTextBtn(
                onTap: () {
                  if (context
                          .read<DiscountController>()
                          .selectedDiscounts
                          .length ==
                      discounts.length) {
                    context.read<DiscountController>().clearSelectedDiscounts();
                    return;
                  }
                  context.read<DiscountController>().selectMultipleDiscounts(discounts.map((e) => e.key).toList(),false);
                },
                child: Text(
                  itemsToDiscountExist(context) ? 'Unselect' : 'Select All',
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
          child: discounts.isEmpty
              ? DefaultMessage(
                  color: StyleColors.lukhuError10,
                  title: 'No Products to Discount',
                  description:
                      'Seems like all you products are on discount or you have no products, add more products to set discount',
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
                      itemCount: discounts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: discounts[index].value,
                        type: ProductType.selectable,
                        isSelected: context
                            .watch<DiscountController>()
                            .selectedDiscounts
                            .containsKey(discounts[index].value.productId),
                        onTap: () {
                          context
                              .read<DiscountController>()
                              .updateSelectedDiscounts(
                                  discounts[index].value.productId!, false);
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
      bottomSheet: discounts.isEmpty
          ? null
          : BottomCard(
              label: 'Set Discount',
              onTap: itemsToDiscountExist(context)
                  ? () {
                      Dialogue.blurredDialogue(
                        distance: 0,
                        context: context,
                        child: DiscountOptions(
                          productIds: [
                            ...context
                                .read<DiscountController>()
                                .selectedDiscounts
                                .entries
                                .where((element) => !element.value)
                                .toList()
                                .map((e) => e.key)
                          ],
                        ),
                      );
                    }
                  : null,
            ),
    );
  }

  bool itemsToDiscountExist(BuildContext context) {
    return context
        .watch<DiscountController>()
        .selectedDiscounts
        .entries
        .where((element) => !element.value)
        .isNotEmpty;
  }
}
