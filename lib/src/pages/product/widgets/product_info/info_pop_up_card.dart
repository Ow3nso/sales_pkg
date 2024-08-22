import 'package:flutter/material.dart';

import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show DefaultBackButton, DefaultButton, StyleColors;
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class InfoPopUpCard extends StatelessWidget {
  const InfoPopUpCard(
      {super.key,
      required this.title,
      required this.child,
      this.onSave,
      this.onCancel,
      this.height = 500});
  final String title;
  final Widget child;
  final void Function()? onSave;
  final void Function()? onCancel;
  final double height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: AppUtil.animationDuration,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              DefaultBackButton(
                onTap: () {
                  if (onCancel != null) onCancel!();
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              Expanded(
                child: Text(title,style: TextStyle(
                  color: StyleColors.lukhuDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                )),
              ),
              const Spacer(),
            ],
          ),
          Expanded(child: child),
           const SizedBox(
            height: 16,
          ),
           DefaultButton(
            onTap: (){
              if (onSave != null) onSave!();
              Navigator.pop(context);
            },
            color: StyleColors.lukhuBlue,
            actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
            label: "Save",
            height: 40,
            width: size.width - 32,
          ),
          
          const SizedBox(
            height: 16,
          ),
          DefaultButton(
            onTap: (){
              if (onCancel != null) onCancel!();
              Navigator.pop(context);
            },
            label: "Cancel",
            color: StyleColors.lukhuWhite,
            height: 40,
            width: size.width - 32,
            boarderColor: StyleColors.lukhuDividerColor,
            textColor: StyleColors.lukhuDark1,
          ),
                    const SizedBox(
            height: 26,
          ),
        ],
      ),
    );
  }
}
