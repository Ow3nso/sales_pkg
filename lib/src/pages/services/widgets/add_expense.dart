import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DateFormat,
        DefaultButton,
        DefaultDropdown,
        DefaultInputField,
        DefaultPrefix,
        ExpenseCategory,
        ExpenseController,
        ReadContext,
        ShortMessageType,
        ShortMessages,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/commands/add_expense_command.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

import 'upload_image_card.dart';

class AddExpense extends StatelessWidget {
  const AddExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: AppUtil.animationDuration,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 700,
        decoration: BoxDecoration(
          color: StyleColors.lukhuWhite,
          border: Border.all(
            color: StyleColors.lukhuDividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Form(
          key: context.watch<ExpenseController>().addExpenseFormKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Add Expense',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: StyleColors.lukhuDark1,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const UploadImageCard(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DefaultInputField(
                  hintText: 'Expense Name',
                  onChange: (value) {},
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  controller: context.watch<ExpenseController>().nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Expense name is required.';
                    }
                    return null;
                  },
                ),
              ),
              DefaultInputField(
                hintText: 'Description',
                onChange: (value) {},
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                controller:
                    context.watch<ExpenseController>().descriptionController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DefaultDropdown(
                  items: ExpenseCategory.values,
                  itemChild: (value) => Text(value.name),
                  onChanged: (value) {
                    context.read<ExpenseController>().category = value;
                  },
                  isExpanded: true,
                  hintWidget: Text(
                    context.watch<ExpenseController>().selectedCategory,
                  ),
                ),
              ),
              DefaultInputField(
                hintText: 'Date',
                onChange: (value) {},
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                onTap: () {
                  _showPicker(context).then((value) {
                    context.read<ExpenseController>().range = value;
                    if (value != null) {
                      context.read<ExpenseController>().dateController.text =
                          '${DateFormat('MMM dd, yyyy').format(value.start)} - ${DateFormat('MMM dd, yyyy').format(value.end)}';
                    }
                  });
                },
                readOnly: true,
                controller: context.watch<ExpenseController>().dateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Date is required.';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DefaultInputField(
                  hintText: '1,500',
                  prefix: const DefaultPrefix(text: 'KSh'),
                  onChange: (value) {},
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  controller:
                      context.watch<ExpenseController>().amountController,
                  textInputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Amount is required.';
                    }
                    return null;
                  },
                ),
              ),
              DefaultInputField(
                hintText: 'Note',
                onChange: (value) {},
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                controller: context.watch<ExpenseController>().noteController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DefaultButton(
                  loading: context.watch<ExpenseController>().isLoading,
                  label: 'Save',
                  onTap: () {
                    if (!context
                        .read<ExpenseController>()
                        .addExpenseFormKey
                        .currentState!
                        .validate()) {
                      ShortMessages.showShortMessage(
                        message: 'Provide all the required fields.',
                        type: ShortMessageType.info,
                      );
                      return;
                    }
                    AddExpenseCommand(context).execute();
                  },
                  width: MediaQuery.sizeOf(context).width,
                  height: 40,
                  color: StyleColors.lukhuBlue,
                  actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DefaultButton(
                  label: 'Cancel',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  width: MediaQuery.sizeOf(context).width,
                  height: 40,
                  textColor: StyleColors.lukhuDark1,
                  color: StyleColors.lukhuWhite,
                  boarderColor: StyleColors.lukhuDividerColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTimeRange?> _showPicker(BuildContext context) async {
    var pickerRange = await showDateRangePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(
          const Duration(days: 7),
        ),
      ),
      confirmText: "Apply",
      cancelText: "Cancel",
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            useMaterial3: true,
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: StyleColors.lukhuBlue70,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                fixedSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    return pickerRange;
  }
}
