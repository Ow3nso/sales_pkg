import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';

class PhotographyBill extends StatelessWidget {
  const PhotographyBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: StyleColors.lukhuGrey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(
            '3 photos per item',
            style: TextStyle(
              color: StyleColors.lukhuDark1,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            'Total: KSh 0',
            style: TextStyle(
              color: StyleColors.lukhuDark1,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
