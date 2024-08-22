import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DefaultDropdown,
        ExpenseCategory,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/widgets/drop_down_tile.dart';

import '../../../controllers/expense_controller.dart';
import '../../../controllers/sell_view_controller.dart';

class ExpenseDropdown extends StatelessWidget {
  const ExpenseDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 35,
            child: DefaultDropdown(
              radius: 8,
              isExpanded: true,
              itemChild: (value) => DropdownTitle(
                iconData: Icons.money,
                title: value.name,
                color: StyleColors.lukhuDark1,
              ),
              onChanged: (value) {
                context.read<ExpenseController>().category = value;
              },
              hintWidget: DropdownTitle(
                iconData: Icons.money,
                title: context.watch<ExpenseController>().selectedCategory,
                color: StyleColors.lukhuDark1,
              ),
              items: ExpenseCategory.values,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            height: 35,
            child: DefaultDropdown(
              radius: 8,
              isExpanded: true,
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
        ),
      ],
    );
  }
}
