import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DefaultButton,
        DefaultDropdown,
        DefaultInputField,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/service_controller.dart';
import 'package:sales_pkg/src/pages/services/widgets/photography_bill.dart';

import 'photography_detail.dart';

class PhotographyService extends StatelessWidget {
  const PhotographyService({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 670,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: StyleColors.lukhuWhite,
          border: Border.all(
            color: StyleColors.lukhuDividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Request Photography Service',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: StyleColors.lukhuDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: PhotographyDetail(),
            ),
            DefaultInputField(
              onChange: (value) {},
              textInputAction: TextInputAction.next,
              hintText: 'Item Name*',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Item name is required!.';
                }
                return null;
              },
              textInputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: DefaultDropdown(
                items: const ["Men", "Women", "Kids", "Unisex"],
                hintWidget: Text(
                    context.watch<ServiceController>().selectedCategory ??
                        "Category*"),
                itemChild: (value) => Text(value),
                onChanged: (value) {},
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DefaultInputField(
                textInputAction: TextInputAction.next,
                onChange: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Quantity is required!.';
                  }
                  return null;
                },
                hintText: 'Quantity*',
                keyboardType: TextInputType.number,
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DefaultInputField(
                textInputAction: TextInputAction.done,
                onChange: (value) {},
                maxLines: 5,
                hintText: 'Note...',
              ),
            ),
            const PhotographyBill(),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: DefaultButton(
                label: 'Submit',
                width: MediaQuery.sizeOf(context).width - 32,
                height: 40,
                color: StyleColors.lukhuBlue,
                onTap: () {},
                actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DefaultButton(
                label: 'Cancel',
                height: 40,
                onTap: () {
                  Navigator.of(context).pop();
                },
                width: MediaQuery.sizeOf(context).width - 32,
                color: StyleColors.lukhuWhite,
                textColor: StyleColors.lukhuDark1,
                boarderColor: StyleColors.lukhuDividerColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
