import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';

import '../../../controllers/add_item_controller.dart';

class CategorDisplay extends StatelessWidget {
  const CategorDisplay({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var list = data['options'];
    return Expanded(
      child: ListView.separated(
        itemCount: list.length,
        itemBuilder: (_, i) {
          final value = list[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: InkWell(
              onTap: () {
                context
                    .read<UploadProductController>()
                    .updateFilterValues(data['name'], value);

                Navigator.of(context).pop();
              },
              child: Row(children: [
                Text(value,
                    style: TextStyle(
                      color: StyleColors.lukhuDark1,
                      fontWeight: FontWeight.w400,
                    ))
              ]),
            ),
          );
        },
        separatorBuilder: (_, index) =>
            Divider(color: StyleColors.lukhuDividerColor),
      ),
    );
  }
}
