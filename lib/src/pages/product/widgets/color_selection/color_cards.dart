import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show StyleColors;

class ColorCard extends StatelessWidget {
  const ColorCard({super.key,required this.onTap,required this.colorLabel, this.selected = false, this.color});
  final String colorLabel;
  final void Function()? onTap;
  final bool selected;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: StyleColors.boarderColor,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: CircleAvatar(
                backgroundColor: color,
                 child: !selected
                    ? null
                    : Icon(
                        Icons.check,
                        color: getFontColorForBackground(color!),
                        size: 20,
                      ),
              ),
            ),
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(colorLabel,textAlign: TextAlign.center,style:  TextStyle(
            color: StyleColors.lukhuDark1,
             fontSize: 10,
             fontWeight: FontWeight.w600
          ),),
        ))
      ],
    );
  }

  Color getFontColorForBackground(Color background) {
    return (background.computeLuminance() > 0.179)
        ? Colors.black
        : Colors.white;
  }
}
