import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultDropdown, ReadContext, StyleColors, WatchContext;
import 'package:sales_pkg/src/pages/seller/widgets/stats_card.dart';

import '../../../controllers/sell_view_controller.dart';
import '../../../widgets/drop_down_tile.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  double padding(bool isLast, double spacing) => isLast ? spacing : 0;

  @override
  Widget build(BuildContext context) {
    var sellerStats = context.read<SellViewController>().sellerStats;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: DefaultDropdown(
              radius: 8,
              itemChild: (value) => DropdownTitle(
                iconData: Icons.calendar_month,
                title: value,
                color: StyleColors.lukhuDark1,
              ),
              onChanged: (value) {
                context.read<SellViewController>().statDuration = value;
              },
              hintWidget: DropdownTitle(
                iconData: Icons.calendar_month,
                title: context.watch<SellViewController>().statDuration ??
                    "This Week",
                color: StyleColors.lukhuDark1,
              ),
              items: context.read<SellViewController>().durations,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                sellerStats.length,
                (index) {
                  var data = sellerStats[index];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: StatsCard(data: data),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
