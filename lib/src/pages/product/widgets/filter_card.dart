import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultBackButton, DefaultButton, FilterType, StyleColors;

import 'filter_child_display.dart';

class FilterCard extends StatelessWidget {
  const FilterCard(
      {super.key,
      this.onPrimary,
      required this.primaryLabel,
      this.onSecondary,
      this.type = FilterType.category,
      required this.secondaryLabel,
      this.height = 400,
      required this.data});
  final void Function()? onPrimary;
  final String primaryLabel;
  final void Function()? onSecondary;
  final String secondaryLabel;

  final FilterType type;
  final Map<String, dynamic> data;
  final double height;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: getConteinerHeights(),
        width: size.width,
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: StyleColors.lukhuDividerColor,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const DefaultBackButton(),
                  Text(
                    data['name'],
                    style: TextStyle(
                      color: StyleColors.lukhuDark1,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
            Expanded(
              child: FilterChildDisplay(
                type: type,
                data: data,
              ),
            ),
            // const Spacer(),

            Column(
              children: [
                DefaultButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  label: 'Apply',
                  color: StyleColors.lukhuBlue,
                  height: 40,
                  width: MediaQuery.of(context).size.width - 64,
                  textColor: StyleColors.lukhuWhite,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            DefaultButton(
              onTap: onSecondary,
              label: secondaryLabel,
              color: StyleColors.lukhuWhite,
              height: 40,
              width: size.width - 64,
              boarderColor: StyleColors.lukhuDividerColor,
              textColor: StyleColors.lukhuDark1,
            ),
          ],
        ),
      ),
    );
  }

  Map<String, double> get conteinerHeights => {
        'setDiscount': 278,
        'markAsSold': 200,
        'dulicateProduct': 150,
        'color': 480,
        'category': 450,
        'condition': 480,
      };

  double getConteinerHeights() => conteinerHeights[type.name] ?? 350;
}
