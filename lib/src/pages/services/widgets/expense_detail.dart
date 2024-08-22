import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DateFormat,
        DefaultBackButton,
        DetailCard,
        ExpenseCategory,
        GlobalAppUtil,
        NumberFormat,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/sales_pkg.dart';

import '../../../utils/styles/app_util.dart';

class ExpenseDetail extends StatelessWidget {
  const ExpenseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 250,
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Recorded Expense',
                  style: TextStyle(
                    color: StyleColors.lukhuDark1,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: DefaultBackButton(
                    assetIcon: AppUtil.closeIcon,
                    packageName: GlobalAppUtil.productListingPackageName,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                DetailCard(
                  title: 'Expense Name',
                  description:
                      context.watch<ExpenseController>().expense?.name ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DetailCard(
                    title: 'Date',
                    description:
                        '${DateFormat('MMM dd, yyyy').format(context.watch<ExpenseController>().expense?.fromdate ?? DateTime.now())} - ${DateFormat('MMM dd, yyyy').format(context.watch<ExpenseController>().expense?.toDate ?? DateTime.now())}',
                  ),
                ),
                DetailCard(
                  title: 'Amount',
                  description: NumberFormat.currency(
                    locale: 'en_US',
                    symbol: 'KES ',
                  ).format(
                      context.watch<ExpenseController>().expense?.amount ?? 0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: StyleColors.lukhuBlue10,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      ExpenseCategory
                          .values[context
                                  .watch<ExpenseController>()
                                  .expense
                                  ?.category
                                  ?.index ??
                              0]
                          .name,
                      style: TextStyle(
                        color: StyleColors.lukhuBlue,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
