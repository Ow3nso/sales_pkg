import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultTextBtn, ImageCard, StyleColors;

import '../../../utils/styles/app_util.dart';

class PhotographyDetail extends StatelessWidget {
  const PhotographyDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ImageCard(
                image: AppUtil.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'This service ensures that your products are well represented on the platform',
                  style: TextStyle(
                    color: StyleColors.lukhuDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
              DefaultTextBtn(
                label: 'Terms and Conditions apply',
                onTap: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}
