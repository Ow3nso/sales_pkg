import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';
import 'package:sales_pkg/src/controllers/discount_controller.dart';
import 'package:sales_pkg/src/pages/discount/widgets/set_discount_option.dart';
import 'package:sales_pkg/src/pages/product/widgets/product_info/product_info_action_btn.dart';

class DiscountOptions extends StatelessWidget {
  DiscountOptions({super.key, required this.productIds});
  final List<String> productIds;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var options = context.read<DiscountController>().discountOptions;
    var title = context.watch<DiscountController>().discountOptionTitle;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: StyleColors.lukhuDividerColor)),
        width: size.width,
        padding: const EdgeInsets.only(top: 10),
        height: 300,
        child: Column(
          children: [
            Row(
              children: [
                DefaultBackButton(
                  onTap: () {
                    if (title != null) {
                      context.read<DiscountController>().discountOptionTitle =
                          null;
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                Expanded(
                  child: Text(
                    context.read<DiscountController>().discountOptionTitle ??
                        'Discount Options',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            if (title == null)
              ...List.generate(options.length, (index) {
                return ProductInfoButton(
                    title: options[index]['name'],
                    value: '',
                    onTap: () {
                      context.read<DiscountController>().discountOptionTitle =
                          options[index]['name'];
                    },
                    listPosition: index);
              }),
            if (title != null)
              SetDiscountOption(
                productIds: productIds,
                type: discountType[title] as DiscountType,
              ),
            if (title == null)
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
              
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultButton(
                      label: 'Cancel',
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: size.width - 32,
                      height: 40,
                      textColor: Theme.of(context).colorScheme.scrim,
                      boarderColor: StyleColors.lukhuDividerColor,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  final Map<String, DiscountType> discountType = {
    'Percentage': DiscountType.percentage,
    'Fixed Amount': DiscountType.fixedAmount,
  };
}
