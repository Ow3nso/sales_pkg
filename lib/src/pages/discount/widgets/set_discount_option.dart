import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultButton, DefaultInputField, ProductFields, ReadContext, StyleColors, WatchContext;
import 'package:sales_pkg/src/controllers/discount_controller.dart';
import 'package:sales_pkg/src/controllers/products_controller.dart';

import '../../../widgets/default_prefix.dart';

enum DiscountType { percentage, fixedAmount }

class SetDiscountOption extends StatelessWidget {
  const SetDiscountOption(
      {super.key,
      required this.productIds,
      this.type = DiscountType.percentage,
      this.onChanged,
      this.showButton = true});
  final DiscountType type;
  final void Function(double)? onChanged;
  final bool showButton;
  final List<String> productIds;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Divider(
          color: StyleColors.lukhuDividerColor,
        ),
        const SizedBox(
          height: 8,
        ),
        if (type == DiscountType.percentage)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                      '${context.watch<DiscountController>().sliderValue.truncate()}%'),
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                  overlayColor: StyleColors.lukhuBlue0,
                  thumbColor: StyleColors.lukhuWhite,
                  activeTrackColor: StyleColors.lukhuBlue70,
                  trackHeight: 6.6,
                  overlappingShapeStrokeColor: StyleColors.lukhuBlue0,
                ),
                child: Slider(
                  min: 0,
                  max: 75,
                  inactiveColor: StyleColors.lukhuBlue0,
                  value: context.watch<DiscountController>().sliderValue,
                  onChanged: (value) {
                    context.read<DiscountController>().sliderValue = value;
                  },
                ),
              ),
            ],
          ),
        if (type == DiscountType.fixedAmount)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: DefaultInputField(
              onChange: (value) {
                if (onChanged != null) {
                  if (double.tryParse(value!) != null) {
                    onChanged!(double.parse(value));
                  }
                }
              },
              prefix: const DefaultPrefix(text: 'KES'),
              keyboardType: TextInputType.number,
              controller: context.read<DiscountController>().discountController,
            ),
          ),
        const SizedBox(
          height: 24,
        ),
        if (showButton)
          Column(
            children: [
              DefaultButton(
                label: 'Set Discount',
                color: StyleColors.lukhuBlue,
                onTap: () {
                  if (type == DiscountType.percentage) {
                    context
                        .read<ProductController>()
                        .setDiscount(
                          type: ProductFields.discountPercentage,
                          productIds: productIds, value: context.read<DiscountController>().sliderValue.truncate().toDouble());
                  } else {
                    context
                        .read<ProductController>()
                        .setDiscount(
                          type: ProductFields.discountAmount,
                          productIds: productIds, value: double.parse(context.read<DiscountController>().discountController.text));
                  }
                  context.read<DiscountController>().discountOptionTitle = null;
                  Navigator.of(context).pop();
                },
                width: size.width - 32,
                actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
                height: 40,
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
                  context.read<DiscountController>().discountOptionTitle = null;
                },
              )
            ],
          )
      ],
    );
  }
}
