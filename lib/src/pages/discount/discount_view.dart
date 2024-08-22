import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        ConfirmationCard,
        DefaultBackButton,
        DefaultIconBtn,
        LuhkuAppBar,
        NavigationService,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/discount_controller.dart';
import 'package:sales_pkg/src/controllers/products_controller.dart';
import 'package:sales_pkg/src/pages/discount/set_discount_view.dart';
import 'package:sales_pkg/src/widgets/bottom_card.dart';
import 'package:sales_pkg/src/widgets/default_message.dart';
import 'package:sales_pkg/src/widgets/product_card.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

import '../../widgets/dialogue.dart';

class DiscountView extends StatelessWidget {
  const DiscountView({super.key});
  static const routeName = 'discounts_view';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var discounts = context
        .watch<ProductController>()
        .products
        .entries
        .where((element) => element.value.isOnDiscount ?? false)
        .toList();
    return Scaffold(
      appBar: LuhkuAppBar(
        enableShadow: true,
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        color: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Discounts',
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
              child: DefaultIconBtn(
                assetImage: AppUtil.trash,
                packageName: AppUtil.packageName,
                onTap: () {
                  removeDiscount(context);
                },
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: discounts.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () => context
                      .read<ProductController>()
                      .getProducts(isrefreshMode: true),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.09,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 9,
                      ),
                      itemCount: discounts.length,
                      itemBuilder: (context, index) => ProductCard(
                        type: ProductType.selectable,
                        product: discounts[index].value,
                        isSelected: context
                            .watch<DiscountController>()
                            .selectedDiscounts
                            .containsKey(discounts[index].value.productId),
                        onTap: () {
                          context
                              .read<DiscountController>()
                              .updateSelectedDiscounts(
                                  discounts[index].value.productId!, true);
                        },
                      ),
                    ),
                  ),
                )
              : DefaultMessage(
                  color: StyleColors.lukhuError10,
                  title: 'You don’t have discounts yet',
                  description:
                      'Add a discount to your store by tapping the button below',
                  onTap: () {
                    NavigationService.navigate(
                        context, SetDiscountView.routeName);
                  },
                  label: 'Add Discount',
                ),
        ),
      ),
      bottomSheet: discounts.isNotEmpty
          ? BottomCard(
              label: 'Add Discount',
              onTap: () {
                NavigationService.navigate(context, SetDiscountView.routeName);
              },
            )
          : null,
    );
  }

  void removeDiscount(BuildContext context) {
    final discountsToremove = context
        .read<DiscountController>()
        .selectedDiscounts
        .entries
        .where((element) => element.value)
        .toList();
    if (discountsToremove.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Select a discount to remove',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          backgroundColor: StyleColors.lukhuError,
        ),
      );
      return;
    }
    Dialogue.blurredDialogue(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ConfirmationCard(
          title: 'Delete Discount',
          description:
              'Are you sure you want to delete this product’s discount?',
          primaryLabel: 'Yes',
          onPrimaryTap: () {
            context
                .read<ProductController>()
                .removeProductsDiscount(
                    productIds: discountsToremove.map((e) => e.key).toList())
                .then((v) {
              context.read<DiscountController>().clearSeletedDiscounts(
                  discountsToremove.map((e) => e.key).toList());
            });
            Navigator.of(context).pop();
          },
          color: StyleColors.lukhuError10,
          secondaryLabel: 'Cancel',
          onSecondaryTap: () {
            Navigator.of(context).pop();
          },
          height: 300,
          assetImage: AppUtil.alertCircle,
          packageName: AppUtil.packageName,
          primaryButtonColor: StyleColors.lukhuError,
        ),
      ),
    );
  }
}
