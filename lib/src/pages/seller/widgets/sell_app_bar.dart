import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DiscountCard, HourGlass, ReadContext, StyleColors, UserRepository;
import 'package:sales_pkg/src/controllers/sell_view_controller.dart';

import '../../../utils/styles/app_util.dart';
import '../../../controllers/add_item_controller.dart';
import '../../../widgets/user_avatar.dart';

class SellAppBar extends StatelessWidget {
  const SellAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<SellViewController>().getUserShop(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(
                  image: context.read<UserRepository>().shop?.imageUrl ??
                      context.read<UploadProductController>().userImageAvatar,
                  isOnline: true,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.read<UserRepository>().shop?.name ?? '@shop',
                      style: TextStyle(
                        color: StyleColors.gray90,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${context.read<UserRepository>().shop?.name ?? 'shop'}.lukhu.shop',
                      style: TextStyle(
                        color: StyleColors.gray90,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DiscountCard(
                      color: StyleColors.lukhuWhite,
                      iconImage: AppUtil.sendIcon,
                      description: 'Share store',
                      style: TextStyle(
                        color: StyleColors.lukhuGrey80,
                        fontWeight: FontWeight.w400,
                      ),
                      packageName: AppUtil.packageName,
                    )
                  ],
                ),
              ],
            );
          }

          return const SizedBox(
            child: Center(
              child: HourGlass(),
            ),
          );
        });
  }
}
