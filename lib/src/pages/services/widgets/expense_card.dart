import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        BlurDialogBody,
        DateFormat,
        Expense,
        ExpenseCategory,
        NumberFormat,
        StyleColors;
import 'package:sales_pkg/src/pages/services/widgets/expense_detail.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, this.onTap, required this.expense});
  final void Function()? onTap;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }

        _showDetail(context);
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: StyleColors.lukhuWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.name ?? '',
                  style: TextStyle(
                    color: StyleColors.lukhuDark1,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${DateFormat('MMM dd, yyyy').format(expense.fromdate ?? DateTime.now())} - ${DateFormat('MMM dd, yyyy').format(expense.toDate ?? DateTime.now())}',
                  style: TextStyle(
                    color: StyleColors.lukhuGrey80,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: StyleColors.lukhuBlue10,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                ExpenseCategory.values[expense.category?.index ?? 0].name,
                style: TextStyle(
                  color: StyleColors.lukhuBlue,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  NumberFormat.currency(
                    locale: 'en_US',
                    symbol: 'KES ',
                  ).format(expense.amount ?? 0),
                  style: TextStyle(
                    color: StyleColors.lukhuGrey500,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  color: StyleColors.lukhuGrey500,
                  size: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDetail(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return const BlurDialogBody(
          child: ExpenseDetail(),
        );
      },
    );
  }
}
