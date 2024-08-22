import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultButton, ReadContext, StyleColors;
import 'package:sales_pkg/src/controllers/add_item_controller.dart';

class TipsCard extends StatelessWidget {
  const TipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var tips = context.read<UploadProductController>().tips;
    return Container(
      height: 680,
      width: size.width,
      decoration: BoxDecoration(
          color: StyleColors.lukhuWhite,
          border: Border.all(color: StyleColors.lukhuDividerColor),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Photo and Video Tips',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: StyleColors.lukhuDark1,
                  fontSize: 18)),
          const SizedBox(
            height: 8,
          ),
          Text(
              'Increase your chances of selling with these simple tips from our Merchant Team',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: StyleColors.lukhuGrey80,
                  fontSize: 14)),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tips.length,
              itemBuilder: (context, index) => SizedBox(
                width: size.width,
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            tips[index]['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(
                        tips[index]['description'],
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: StyleColors.lukhuDark,
                            fontSize: 12),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          DefaultButton(
            label: 'Cancel',
            color: StyleColors.lukhuWhite,
            width: size.width - 32,
            boarderColor: StyleColors.lukhuDividerColor,
            textColor: StyleColors.lukhuDark1,
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
