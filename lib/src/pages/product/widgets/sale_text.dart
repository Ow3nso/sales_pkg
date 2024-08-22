import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';

class SaleText extends StatelessWidget {
  const SaleText({super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: StyleColors.lukhuGrey70,
          ),
        ),
        Text(
          description,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: StyleColors.lukhuGrey70,
          ),
        )
      ],
    );
  }
}
