import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';

class ProductBottomCard extends StatelessWidget {
  const ProductBottomCard(
      {super.key,
      required this.primaryLabel,
      this.onPrimary,
      required this.secondaryLabel,
      this.onSecondary,
      this.secondaryLoading = false,
      this.primaryLoading = false
      });
  final String primaryLabel;
  final void Function()? onPrimary;
  final String secondaryLabel;
  final void Function()? onSecondary;
  final bool secondaryLoading;
  final bool primaryLoading;  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 180,
      width: size.width,
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
        border: Border(
          top: BorderSide(
            color: StyleColors.lukhuDividerColor,
          ),
        ),
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 27,
        bottom: 70,
      ),
      child: Row(
        children: [
          Expanded(
            child: DefaultButton(
              loading: secondaryLoading,
              color: StyleColors.lukhuWhite,
              label: secondaryLabel,
              height: 40,
              boarderColor: StyleColors.lukhuDividerColor,
              onTap: onSecondary,
              textColor: StyleColors.lukhuDark1,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: DefaultButton(
              loading: primaryLoading,
              color: StyleColors.lukhuBlue,
              label: primaryLabel,
              height: 40,
              onTap: onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
