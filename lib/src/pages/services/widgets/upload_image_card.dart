import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show StyleColors;

import '../../../utils/styles/app_util.dart';

class UploadImageCard extends StatelessWidget {
  const UploadImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: StyleColors.lukhuWhite,
          border: Border.all(
            color: StyleColors.lukhuDividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Image.asset(
              AppUtil.uploadIcon,
              package: AppUtil.packageName,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Text(
                'Click to take a photo or upload',
                style: TextStyle(
                  color: StyleColors.lukhuBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              'SVG, PNG, JPG or GIF (max. 800x800px)',
              style: TextStyle(
                color: StyleColors.lukhuGrey80,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
