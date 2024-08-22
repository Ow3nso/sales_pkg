import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show CartController, NavigationService, StyleColors, WatchContext;
import 'package:sales_pkg/src/widgets/bottom_card.dart';

class BillingCard extends StatelessWidget {
  const BillingCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 235,
      child: Column(
        children: [
          _billingTile(
              size,
              'Items',
              "${context.watch<CartController>().getBagQuantity()}",
              context.watch<CartController>().cart.isNotEmpty),
          _billingTile(
              size,
              'Total',
              context.watch<CartController>().cartTotal.toStringAsFixed(2),
              context.watch<CartController>().cart.isNotEmpty),
          BottomCard(
            label: 'Checkout',
            onTap: context.watch<CartController>().cart.isNotEmpty
                ? () {
                    NavigationService.navigate(context, "checkout_view");
                  }
                : null,
          )
        ],
      ),
    );
  }

  Container _billingTile(
      Size size, String title, String description, bool show) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: StyleColors.lukhuGrey10,
          border: show
              ? Border(top: BorderSide(color: StyleColors.lukhuDividerColor))
              : null),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            show ? title : "",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: StyleColors.lukhuDark,
            ),
          ),
          Text(
            show ? description : "",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: StyleColors.lukhuDark,
            ),
          )
        ],
      ),
    );
  }
}
