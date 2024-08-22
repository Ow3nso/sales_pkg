import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';

class DefaultPrefix extends StatelessWidget {
  const DefaultPrefix({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(color: StyleColors.lukhuDividerColor))),
        child: Text(
          text,
          style: TextStyle(
              color: StyleColors.gray90,
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
      ),
    );
  }
}
