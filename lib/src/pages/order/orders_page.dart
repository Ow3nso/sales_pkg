import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        DefaultBackButton,
        DefaultCallBtn,
        LuhkuAppBar,
        StyleColors;

import 'widgets/orders_container.dart';
import 'widgets/return_order_container.dart';

enum OrderViewType { sales, account }

class OrdersViewPage extends StatelessWidget {
  const OrdersViewPage({super.key});
  static const routeName = 'orders';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var args = ModalRoute.of(context)!.settings.arguments;
    final showButton = args != null;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: LuhkuAppBar(
          backAction: showButton ? const DefaultBackButton() : null,
          appBarType: AppBarType.other,
          enableShadow: true,
          height: 105,
          color: Theme.of(context).colorScheme.onPrimary,
          title: Text(
            'Orders',
            style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: DefaultCallBtn(),
            ),
          ],
          bottomHeight: kTextTabBarHeight,
          bottom: TabBar(
            onTap: (index) {},
            indicatorColor: StyleColors.lukhuDark,
            labelColor: StyleColors.lukhuDark,
            labelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            unselectedLabelColor: StyleColors.lukhuDark,
            unselectedLabelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            tabs: const [
              Tab(
                text: 'Orders',
              ),
              Tab(
                text: 'Returns',
              )
            ],
          ),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBarView(
              children: _views,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get _views => const [
        OrdersContainer(),
        ReturnedOrderContainer(),
      ];
}
