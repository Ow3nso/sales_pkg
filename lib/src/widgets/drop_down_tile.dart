import 'package:flutter/material.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class DropdownTitle extends StatelessWidget {
  const DropdownTitle(
      {super.key,
      this.iconData,
      this.color,
      required this.title,
      this.assetImage});
  final IconData? iconData;
  final Color? color;
  final String title;
  final String? assetImage;

  @override
  Widget build(BuildContext context) {
    return Row(verticalDirection: VerticalDirection.up, children: [
      iconData == null
          ? Image.asset(
              assetImage!,
              package: AppUtil.packageName,
            )
          : Icon(
              iconData,
              color: color,
              size: 16,
            ),
      const SizedBox(width: 4),
      Text(
        title,
        style:
            TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12),
      )
    ]);
  }
}
