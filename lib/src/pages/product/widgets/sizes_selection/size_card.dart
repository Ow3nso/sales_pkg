import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show StyleColors;

class SizeCard extends StatelessWidget {
  const SizeCard(
      {super.key,
      required this.onTap,
      required this.size,
      this.selected = false});
  final String size;
  final void Function(String) onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 51,
      height: 51,
      decoration: BoxDecoration(
        color: selected? StyleColors.lukhuDark1 : null,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: StyleColors.greyWeak1,
          )),
      child: InkWell(
        onTap: (() => onTap(size)),
        child: Center(child: Text(size,style: TextStyle(
          color: selected ? Colors.white: StyleColors.greyWeak1,
          fontSize: 14,fontWeight: FontWeight.w700),)),
      ),
    );
  }
}
