import 'package:flutter/material.dart';

import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show StyleColors;

class ProductInfoButton extends StatelessWidget {
  const ProductInfoButton(
      {super.key,
      required this.title,
      required this.value,
      required this.onTap,
      required this.listPosition,
      this.showAction = true});
  final String title;
  final String? value;
  final void Function()? onTap;
  final int listPosition;
  final bool showAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: StyleColors.lukhuDividerColor),
            top: BorderSide(
              width: listPosition == 0 ? 1 : .05,
              color: StyleColors.lukhuDividerColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(title,
                style: TextStyle(
                  color: StyleColors.lukhuDark1,
                  fontWeight: FontWeight.w700,
                )),
            const Spacer(),
            Text(value ?? 'Tap to add',
                style: TextStyle(
                  color: StyleColors.lukhuGrey80,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                )),
            if(showAction)
            Icon(
              Icons.arrow_forward_ios,
              color: StyleColors.lukhuDark1,
              size: 20,
              semanticLabel: 'Tap to add',
            )
          ],
        ),
      ),
    );
  }
}
