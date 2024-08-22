import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DefaultTextBtn,
        Expense,
        GraphContainer,
        NavigationService,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/sales_pkg.dart';
import 'package:sales_pkg/src/pages/services/widgets/expense_card.dart';

import '../pages/all_expense.dart';
import 'expense_dropdown.dart';

class ExpenseDetailSection extends StatelessWidget {
  const ExpenseDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            decoration: BoxDecoration(
              color: StyleColors.lukhuWhite,
            ),
            child: const GraphContainer(
              child: ExpenseDropdown(),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Your Expenses',
                      style: TextStyle(
                        color: StyleColors.lukhuDark1,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  DefaultTextBtn(
                    label: 'See All',
                    onTap: () {
                      NavigationService.navigate(context, AllExpense.routeName);
                    },
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: StyleColors.lukhuWhite,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount:
                    context.watch<ExpenseController>().expenses.keys.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ExpenseCard(
                    expense: _expense(context, index)!,
                    onTap: () {
                      context.read<ExpenseController>().expense =
                          _expense(context, index)!;
                    },
                  ),
                ),
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  color: StyleColors.lukhuDividerColor,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Expense? _expense(BuildContext context, int index) {
    return context
        .read<ExpenseController>()
        .expenses[_expenseKey(context, index)];
  }

  String _expenseKey(BuildContext context, int index) {
    return context.read<ExpenseController>().expenses.keys.elementAt(index);
  }
}
