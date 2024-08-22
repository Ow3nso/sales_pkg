import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show ReadContext, WatchContext;
import 'package:sales_pkg/src/utils/styles/app_util.dart';

import '../../../../controllers/add_item_controller.dart';
import 'color_cards.dart';

class ColorsSelectionCard extends StatelessWidget {
  const ColorsSelectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppUtil.optionColors;
    return GridView.count(
      crossAxisCount: 6,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: colors
          .map((e) => ColorCard(
              selected: context
                  .watch<UploadProductController>()
                  .selectedColors
                  .contains(e["name"]),
              onTap: () {
                context
                    .read<UploadProductController>()
                    .updateSelectedColors(e["name"]);
              },
              colorLabel: e["name"],
              color: e["color"]))
          .toList(),
    );
  }
}
