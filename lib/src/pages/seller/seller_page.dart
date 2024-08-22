import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        DiscountCard,
        Helpers,
        LuhkuAppBar,
        NotificationIcon,
        ReadContext,
        StyleColors,
        UserRepository,
        WatchContext;
import 'package:sales_pkg/src/controllers/customer_controller.dart';
import 'package:sales_pkg/src/controllers/merchant_controller.dart';
import 'package:sales_pkg/src/pages/seller/widgets/action_view_card.dart';
// import 'package:sales_pkg/src/pages/seller/widgets/pin_card.dart';
import 'package:sales_pkg/src/pages/seller/widgets/resource_section.dart';
// import 'package:sales_pkg/src/widgets/dialogue.dart';

import '../../utils/styles/app_util.dart';
import '../../widgets/user_avatar.dart';
import 'widgets/category_card.dart';
import 'widgets/stats_section.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});
  static const routeName = 'sell_page';

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerController>().shopId =
          context.read<UserRepository>().fbUser?.uid ?? "";
      if (!context.read<MerchantController>().showBackButton) {
        return;
      }
      Helpers.debugLog(
          '[USER-ID]${context.read<UserRepository>().fbUser?.uid}');
      context.read<MerchantController>().showBackButton = false;
      // Dialogue.blurredDialogue(
      //     context: context,
      //     distance: 100,
      //     child: const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //       child: PinCard(),
      //     ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: LuhkuAppBar(
        bottomHeight: 1,
        color: StyleColors.sellPageAppBarColor,
        appBarType: AppBarType.other,
        backAction: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: UserAvatar(
            image: context.watch<UserRepository>().shop?.imageUrl,
            isOnline: true,
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.watch<UserRepository>().shop?.name ?? '',
                  style: TextStyle(
                    color: StyleColors.gray90,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Text(
                  context.read<UserRepository>().shop?.webDomain ?? '',
                  style: TextStyle(
                    color: StyleColors.gray90,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DiscountCard(
                color: StyleColors.lukhuBlue,
                iconImage: AppUtil.sendIcon,
                imageColor: StyleColors.lukhuWhite,
                description: 'Share store',
                style: TextStyle(
                  color: StyleColors.lukhuWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                packageName: AppUtil.packageName,
                onTap: () {},
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 24, right: 16),
            child: NotificationIcon(),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView.builder(
          itemCount: _views.length,
          itemBuilder: (context, index) => _views[index],
        ),
      ),
    );
  }

  List<Widget> get _views => [
        const StatsSection(),
        const SizedBox(height: 0),
        const ActionViewCard(),
        const CategoryCard(),
        const ResourceSection()
      ];

  double padding(bool isLast, double spacing) => isLast ? spacing : 0;
}
