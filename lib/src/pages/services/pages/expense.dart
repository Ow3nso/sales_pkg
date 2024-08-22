import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        BlurDialogBody,
        DefaultBackButton,
        DefaultMessage,
        HourGlass,
        LuhkuAppBar,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/expense_controller.dart';

import '../../../utils/styles/app_util.dart';
import '../widgets/add_expense.dart';
import '../widgets/expense_detail_section.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});
  static const routeName = 'expense';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LuhkuAppBar(
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        enableShadow: true,
        color: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Expenses',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: FutureBuilder(
          future: context.read<ExpenseController>().getShopExpenses(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (context.watch<ExpenseController>().expenses.keys.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: DefaultMessage(
                      title: 'You currently have no Expenses',
                      assetImage: AppUtil.graphIcon,
                      color: Colors.white,
                      description:
                          'Tap the button below to add expense categories and monitor expenses',
                      label: 'Add Expense',
                      onTap: () {
                        _showAddExpense(context);
                      },
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ExpenseController>().getShopExpenses(
                        isRefreshMode: true,
                      );
                },
                child: const ExpenseDetailSection(),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: DefaultMessage(
                    title: 'An error occurred',
                    assetImage: AppUtil.productIcon,
                    color: StyleColors.lukhuError10,
                    description: '${snapshot.error ?? ''}',
                    label: 'Refresh',
                    onTap: () {
                      context.read<ExpenseController>().getShopExpenses();
                    },
                  ),
                ),
              );
            }
            return const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: HourGlass(),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showAddExpense(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return const BlurDialogBody(
          bottomDistance: 80,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AddExpense(),
          ),
        );
      },
    );
  }
}
