import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show FilterType, InfoCard, InfoCardType, ReadContext, WatchContext;
import 'package:sales_pkg/src/controllers/add_item_controller.dart';

import '../../../controllers/discount_controller.dart';
import '../../discount/widgets/set_discount_option.dart';
import 'category_display.dart';
import 'color_display.dart';

class FilterChildDisplay extends StatelessWidget {
  FilterChildDisplay({super.key, required this.type, required this.data});
  final FilterType type;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var options = context.read<DiscountController>().discountOptions;
    var title = context.watch<DiscountController>().discountOptionTitle;
    switch (type) {
      case FilterType.color:
        return ColorDisplay(data: data);
      case FilterType.category:
        return CategorDisplay(data: data);
      case FilterType.condition:
        return CategorDisplay(data: data);
      case FilterType.setDiscount:
        return Column(
          children: [
            if (title == null)
              ...List.generate(options.length, (index) {
                return InfoCard(
                  data: options[index],
                  type: InfoCardType.other,
                  showBottomBorder: index == options.length - 1,
                  onTap: () {
                    context.read<DiscountController>().discountOptionTitle =
                        options[index]['name'];
                    context.read<UploadProductController>().selectedKey =
                        options[index]['name'];
                  },
                );
              }),
            if (title != null)
              SetDiscountOption(
                productIds: const [],
                  showButton: false,
                  type: discountType[title] as DiscountType,
                  onChanged: (value) {
                    context.read<UploadProductController>().setDiscount(
                        value.toInt().toStringAsFixed(0),
                        discountType[title] as DiscountType);
                  }),
          ],
        );

      default:
        return CategorDisplay(data: data);
    }
  }

  final Map<String, DiscountType> discountType = {
    'Percentage': DiscountType.percentage,
    'Fixed Amount': DiscountType.fixedAmount,
  };
}
