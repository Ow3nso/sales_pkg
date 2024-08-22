import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DefaultButton,
        DefaultInputField,
        DiscountCard,
        MapCard,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/customer_controller.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class AddLocationCard extends StatelessWidget {
  const AddLocationCard({super.key, this.height = 300, this.addLocation});
  final double height;
  final void Function()? addLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
        border: Border.all(
          color: StyleColors.lukhuDividerColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            "Add an address",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: StyleColors.lukhuDark1,
            ),
          ),
          Text(
            "Search for your location below and select it",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: StyleColors.lukhuGrey50,
            ),
          ),
          const MapCard(),
          DefaultInputField(
            onChange: (value) {},
            hintText: "",
            controller: context.watch<CustomerController>().addressController,
            keyboardType: TextInputType.streetAddress,
          ),
          DefaultInputField(
            onChange: (value) {},
            controller: context.watch<CustomerController>().buildingController,
            hintText: "",
          ),
          Row(
            children: List.generate(
              context.watch<CustomerController>().addressCategory.length,
              (index) {
                var item =
                    context.watch<CustomerController>().addressCategory[index];
                return Expanded(
                  child: DiscountCard(
                    color: item['isSelected']
                        ? StyleColors.lightPink
                        : StyleColors.greyWeak,
                    iconImage: item['image'],
                    packageName: AppUtil.packageName,
                    imageColor: item['isSelected']
                        ? StyleColors.lukhuWhite
                        : StyleColors.greyWeak,
                    onTap: () {
                      context.read<CustomerController>().selectedAddress = item;
                    },
                  ),
                );
              },
            ),
          ),
          DefaultButton(
            height: 40,
            label: "Add Address",
            color: StyleColors.lukhuBlue,
            actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
            onTap: () {},
          ),
          DefaultButton(
            height: 40,
            label: "Cancel",
            color: StyleColors.lukhuWhite,
            boarderColor: StyleColors.lukhuDividerColor,
            onTap: () {
              context.read<CustomerController>().addressController =
                  TextEditingController();
              context.read<CustomerController>().toggleAddress();
              Navigator.of(context).pop();
            },
            textColor: StyleColors.lukhuDark1,
          )
        ],
      ),
    );
  }
}
