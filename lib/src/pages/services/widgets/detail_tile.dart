import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultTextBtn, StyleColors;

class DetailTile extends StatelessWidget {
  const DetailTile({
    super.key,
    required this.item,
    this.onTap,
    this.index = 0,
  });
  final void Function()? onTap;
  final int index;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: StyleColors.lukhuDividerColor),
          ),
        ),
        padding:
            const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            Image.asset(
              item['image'],
              package: item['package'],
              height: 20,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item['title'],
                style: TextStyle(
                  color: StyleColors.lukhuDark1,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            Text(
              item['lable'],
              style: TextStyle(
                color: item['color'] ?? StyleColors.lukhuGrey50,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (item['showEdit'])
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: DefaultTextBtn(
                  label: "Edit",
                  underline: false,
                  onTap: () {},
                ),
              ),
            if (item['showIcon'])
              Icon(
                Icons.arrow_forward_ios,
                color: StyleColors.lukhuDark1,
              )
          ],
        ),
      ),
    );
  }
}
