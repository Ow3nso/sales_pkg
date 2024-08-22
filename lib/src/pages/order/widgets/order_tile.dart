import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DateFormat, ImageCard, OrderModel, StyleColors;

class OrderTileCard extends StatelessWidget {
  const OrderTileCard({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: StyleColors.lukhuDividerColor,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ImageCard(
                image: order.items!.first.orderImages!.first,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEE d MMM, h:mm a').format(order.createdAt!),
                  style: TextStyle(
                    color: StyleColors.lukhuGrey50,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Text(
                  order.name ?? '',
                  style: TextStyle(
                    color: StyleColors.lukhuDark1,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text.rich(TextSpan(
                    text: 'Order Number:\t',
                    style: TextStyle(
                      color: StyleColors.lukhuDark1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: order.orderId ?? '',
                        style: TextStyle(
                          color: StyleColors.lukhuDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
