import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AuthGenesisPage,
        NavigationController,
        NavigationService,
        ReadContext,
        StyleColors,
        UserRepository;

import '../../../utils/styles/app_util.dart';
import '../../../controllers/sell_view_controller.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    var categories = context.read<SellViewController>().categories;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: StyleColors.lukhuWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(categories.length, (index) {
            var data = categories[index];
            return InkWell(
              onTap: () {
                //var value = categories[index]["isExternal"];

                _navigate(categories, index, context, data);
              },
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: data['color'],
                    radius: 28,
                    child: Image.asset(
                      data['image'],
                      package: AppUtil.packageName,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    data['title'],
                    style: TextStyle(
                      color: StyleColors.lukhuDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void _navigate(List<Map<String, dynamic>> categories, int index,
      BuildContext context, Map<String, dynamic> data) {
    if (categories[index]["isExternal"]) {
      if (context
                  .read<NavigationController>()
                  .guardedRoutes[categories[index]['route']] !=
              null &&
          !context.read<UserRepository>().userAuthenticated) {
        NavigationService.navigate(context, AuthGenesisPage.routeName);
        context.read<NavigationController>().pendingRoute =
            categories[index]['route'];
        return;
      }
      context
          .read<NavigationController>()
          .navigateHomePage(categories[index]["value"]);
      return;
    }
    NavigationService.navigate(
      context,
      data['route'],
      arguments: {
        "show": true,
      },
    );
  }
}
