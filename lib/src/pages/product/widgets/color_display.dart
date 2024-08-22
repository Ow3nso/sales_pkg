import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show FilterColor, ReadContext, WatchContext;

import '../../../controllers/add_item_controller.dart';

class ColorDisplay extends StatelessWidget {
  const ColorDisplay({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var list = data['options'];
    return FilterColor(
      crossAxisCount: 4,
      onTap: (value) {
        context.read<UploadProductController>().selectedFilterColor =
            value['name'];
        context
            .read<UploadProductController>()
            .selectedColors
            .add(value['name']);
        context.read<UploadProductController>().updateFilterValues(
              data['name'],
              context
                  .read<UploadProductController>()
                  .selectedColors
                  .toList()
                  .toString(),
            );
      },
      onChanged: (value) {
        context.read<UploadProductController>().chooseAnyColor = value ?? false;
        context.read<UploadProductController>().selectedFilterColor = '';
        if (value ?? false) {
          context
              .read<UploadProductController>()
              .updateFilterValues(data['name'], 'Any');
        }
      },
      isSelected: context.watch<UploadProductController>().chooseAnyColor,
      data: list,
      isColorSame: (value) =>
          context.read<UploadProductController>().selectedFilterColor == value,
    );
  }
}
