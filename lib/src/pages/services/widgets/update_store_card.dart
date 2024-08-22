import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultButton, StyleColors;
import 'package:sales_pkg/src/pages/services/widgets/store_content.dart';

class UpdateStoreCard extends StatelessWidget {
  UpdateStoreCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
    this.index = 0,
  });
  final String title;
  final String description;
  final void Function()? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: titles[index]!['height'] ?? 300,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: StyleColors.lukhuWhite,
          border: Border.all(color: StyleColors.lukhuDividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                titles[index]!['title'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: StyleColors.lukhuDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                titles[index]!['description'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: StyleColors.greyWeak1,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            StoreContent(
              index: index,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 16),
              child: DefaultButton(
                label: "Cancel",
                onTap: () {
                  Navigator.of(context).pop();
                },
                width: MediaQuery.sizeOf(context).width - 32,
                color: StyleColors.lukhuWhite,
                textColor: StyleColors.lukhuDark1,
                boarderColor: StyleColors.lukhuDividerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Map<int, Map<String, dynamic>> titles = {
    0: {
      'title': 'Update your Store Link',
      'description':
          'Your store link enables customers to find you easily on the internet',
      'height': 370.0,
    },
    1: {
      'title': 'Update your Store Name',
      'description':
          'Your store name enables customers to find you easily on the Lukhu app',
      'height': 270.0,
    },
    2: {
      'title': 'Update your Store Username and Description',
      'description':
          'Your store username enables customers to find you easily on the Lukhu app',
      'height': 440.0,
    }
  };
}
