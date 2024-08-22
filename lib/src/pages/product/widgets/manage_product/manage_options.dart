import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';
import 'package:sales_pkg/src/pages/product/widgets/product_info/product_info_action_btn.dart';

import '../../../discount/widgets/discount_options.dart';

class ManageProductOptions extends StatelessWidget {
  const ManageProductOptions({super.key,required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Text(
            "Manage your product",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        ProductInfoButton(
            title: "Set a discount",
            value: '',
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return BlurDialogBody(
                      child: DiscountOptions(productIds: [productId],),
                    );
                  });
            },
            listPosition: 0),
        ProductInfoButton(
            title: "Boost product", value: '', onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Coming soon"),
              ));
            }, listPosition: 1),
        ProductInfoButton(
            title: "Duplicate  product",
            value: '',
            onTap: () {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Coming soon"),
              ));
            },
            listPosition: 1),
      ],
    );
  }
}
