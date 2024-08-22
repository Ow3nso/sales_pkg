import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultButton, StyleColors;

import '../utils/styles/app_util.dart';

class DefaultMessage extends StatelessWidget {
  const DefaultMessage({
    super.key,
    this.color,
    required this.title,
    required this.description,
    required this.label,
    this.onTap,
    this.assetImage,
    this.packageName = 'sales_pkg'
  });
  final Color? color;
  final String title;
  final String description;
  final String label;
  final void Function()? onTap;
  final String? assetImage;
  final String packageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color ?? StyleColors.lukhuError10,
          child: CircleAvatar(
            backgroundColor: color,
            radius: 20,
            child: Image.asset(
              assetImage ?? AppUtil.discount,
              package: packageName,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: TextStyle(
            color: StyleColors.lukhuDark1,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: StyleColors.lukhuGrey80,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        DefaultButton(
          label: label,
          onTap: onTap,
          color: StyleColors.lukhuBlue,
        )
      ],
    );
  }
}
