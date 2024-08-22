import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        BlurDialogBody,
        DefaultCheckbox,
        FilterCardNotifications,
        ListingFilterButton,
        NotificationType,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/order_controller.dart';

import '../../../utils/styles/app_util.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: ListingFilterButton(
              onTap: () {
                filter(context);
              },
              title: 'Filter',
              image: AppUtil.filterListingIcon,
              packageName: AppUtil.packageName,
            ),
          ),
          Container(
            height: 32,
            width: 1,
            decoration: BoxDecoration(
              color: StyleColors.lukhuDividerColor,
            ),
          ),
          Expanded(
            child: DefaultCheckbox(
              activeColor: StyleColors.lukhuBlue10,
              checkedColor: StyleColors.lukhuBlue70,
              value: context.watch<OrderController>().showItemsBought,
              onChanged: (value) {
                context.read<OrderController>().showItemsBought =
                    value ?? false;
              },
              title: Text(
                'Bought Items',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            height: 32,
            width: 1,
            decoration: BoxDecoration(
              color: StyleColors.lukhuDividerColor,
            ),
          ),
          Expanded(
            child: DefaultCheckbox(
              activeColor: StyleColors.lukhuBlue10,
              checkedColor: StyleColors.lukhuBlue70,
              value: context.watch<OrderController>().showItemsSold,
              onChanged: (value) {
                context.read<OrderController>().showItemsSold = value ?? false;
              },
              title: Text(
                'Sold Items',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void filter(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlurDialogBody(
        bottomDistance: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilterCardNotifications(
            notificationType: NotificationType.orders,
            assetImage: AppUtil.iconBoxSearch,
            title: 'Filter Your Orders',
            description: 'Select a status below to filter your orders',
          ),
        ),
      ),
    );
  }
}
