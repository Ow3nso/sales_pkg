import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show BaseCommand, ShortMessageType, ShortMessages;

class AddExpenseCommand extends BaseCommand {
  AddExpenseCommand(super.c);

  @override
  Future<bool> clear() async {
    expenseController.init();
    return true;
  }

  @override
  Future<void> execute() async {
    expenseController.isLoading = true;

    expenseController.addExpense().then((value) {
      expenseController.isLoading = false;
      if (value) {
        clear();
        expenseController.getShopExpenses(isRefreshMode: true);

        ShortMessages.showShortMessage(message: 'Successfully added');
        Navigator.of(context).pop();
      } else {
        ShortMessages.showShortMessage(
          message: 'Something happened',
          type: ShortMessageType.info,
        );
      }
    });
  }
}
