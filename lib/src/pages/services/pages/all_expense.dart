import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        BlurDialogBody,
        DefaultBackButton,
        DefaultIconBtn,
        DefaultMessage,
        Expense,
        HourGlass,
        LuhkuAppBar,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/expense_controller.dart';
import 'package:sales_pkg/src/pages/services/widgets/add_expense.dart';
import 'package:sales_pkg/src/pages/services/widgets/expense_card.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class AllExpense extends StatelessWidget {
  const AllExpense({super.key});
  static const routeName = 'expenes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LuhkuAppBar(
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        enableShadow: true,
        color: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Your Expenses',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DefaultIconBtn(
              assetImage: AppUtil.addIcon,
              packageName: AppUtil.packageName,
              onTap: () => _showAddExpense(context),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: StyleColors.lukhuWhite,
        ),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: FutureBuilder(
          future: context.read<ExpenseController>().getShopExpenses(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (context.watch<ExpenseController>().expenses.keys.isEmpty) {
                return Center(
                  child: DefaultMessage(
                    title: 'You currently have no Expenses',
                    assetImage: AppUtil.graphIcon,
                    description:
                        'Tap the button below to add expense categories and monitor expenses',
                    label: 'Add Expense',
                    onTap: () {},
                  ),
                );
              }

              return ListView(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) => Divider(
                      color: StyleColors.lukhuDividerColor,
                    ),
                    itemCount:
                        context.watch<ExpenseController>().expenses.keys.length,
                    itemBuilder: (context, index) => ExpenseCard(
                      expense: _expense(context, index)!,
                      onTap: () {
                        context.read<ExpenseController>().expense =
                            _expense(context, index)!;
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
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

  Expense? _expense(BuildContext context, int index) {
    return context
        .read<ExpenseController>()
        .expenses[_expenseKey(context, index)];
  }

  String _expenseKey(BuildContext context, int index) {
    return context.read<ExpenseController>().expenses.keys.elementAt(index);
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
