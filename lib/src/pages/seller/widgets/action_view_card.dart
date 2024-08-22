import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AuthGenesisPage,
        NavigationController,
        NavigationService,
        ReadContext,
        StyleColors,
        UserRepository;

import '../../../controllers/sell_view_controller.dart';

class ActionViewCard extends StatelessWidget {
  const ActionViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    var viewActions = context.read<SellViewController>().sellerViewAction;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: List.generate(viewActions.length, (index) {
          var action = viewActions[index];
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: InkWell(
                onTap: () {
                  _navigate(action, index, context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: action['color'],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        action['title'],
                        style: TextStyle(
                          color: StyleColors.lukhuWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: StyleColors.lukhuWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          action['icon'],
                          color: action['color'],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _navigate(Map<String, dynamic> action, int index, BuildContext context) {
    if (action["isExternal"]) {
      if (context.read<NavigationController>().guardedRoutes[action['route']] !=
              null &&
          !context.read<UserRepository>().userAuthenticated) {
        NavigationService.navigate(context, AuthGenesisPage.routeName);
        context.read<NavigationController>().pendingRoute = action['route'];
        return;
      }
      context.read<NavigationController>().navigateHomePage(action["value"]);
      return;
    }
    NavigationService.navigate(context, action['route'],
        arguments: {"show": true});
  }

  double padding(bool isLast, double spacing) => isLast ? spacing : 0;
}
