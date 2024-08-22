import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultTextBtn, StyleColors;

class StoreDetial extends StatelessWidget {
  const StoreDetial({
    super.key,
    required this.title,
    this.label = "",
    this.onTapLabel,
    this.children = const [],
  });
  final String title;
  final String label;
  final void Function()? onTapLabel;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
        border: Border.all(
          color: StyleColors.lukhuDividerColor,
        ),
      ),
      padding: const EdgeInsets.only(top: 14, bottom: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: StyleColors.pink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                DefaultTextBtn(
                  label: label,
                  onTap: onTapLabel,
                  underline: false,
                )
              ],
            ),
          ),
          Divider(
            color: StyleColors.lukhuDividerColor,
          ),
          ...children
        ],
      ),
    );
  }
}
