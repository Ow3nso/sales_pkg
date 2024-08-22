import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultButton, StyleColors;

class BottomCard extends StatelessWidget {
  const BottomCard({super.key, required this.label, this.onTap, this.height});
  final String label;
  final void Function()? onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: size.width,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
      padding: const EdgeInsets.only(
        top: 27,
        left: 16,
        right: 16,
        bottom: 75,
      ),
      child: DefaultButton(
        label: label,
        onTap: onTap,
        height: 40,
        actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
        color: StyleColors.lukhuBlue,
        width: size.width - 32,
        textColor: StyleColors.lukhuWhite,
      ),
    );
  }
}
