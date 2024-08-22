import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AddAddressCard,
        AppBarType,
        BlurDialogBody,
        DateFormat,
        DefaultBackButton,
        DefaultDropdown,
        DefaultIconBtn,
        DefaultInputField,
        FieldsValidator,
        Helpers,
        HourGlass,
        LocationController,
        LuhkuAppBar,
        ReadContext,
        ShortMessages,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/customer_controller.dart';
import 'package:sales_pkg/src/widgets/bottom_card.dart';
import 'package:sales_pkg/src/widgets/drop_down_tile.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

import '../../../widgets/default_prefix.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});
  static const routeName = 'add_customer';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context.read<LocationController>().retainLocation = false;
        return true;
      },
      child: Scaffold(
        appBar: LuhkuAppBar(
          backAction: DefaultBackButton(
            onTap: () {
              context.read<LocationController>().retainLocation = false;
              Navigator.of(context).pop(true);
            },
          ),
          title: Text(
            'Add Customer',
            style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          color: Theme.of(context).colorScheme.onPrimary,
          appBarType: AppBarType.other,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: DefaultIconBtn(
                assetImage: AppUtil.callImageIcon,
                packageName: AppUtil.packageName,
                onTap: () {},
              ),
            )
          ],
          enableShadow: true,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Form(
            key: context.watch<CustomerController>().formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 10),
                  child: DefaultInputField(
                    controller:
                        context.watch<CustomerController>().nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onChange: (p0) {},
                    label: 'Customer Details',
                    hintText: 'Name*',
                    prefix: Image.asset(
                      AppUtil.userIcon,
                      package: AppUtil.packageName,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DefaultInputField(
                    controller:
                        context.watch<CustomerController>().phoneController,
                    validator: FieldsValidator.phoneValidator,
                    onChange: (p0) {},
                    keyboardType: TextInputType.phone,
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    hintText: 'Phone Number*',
                    prefix: const DefaultPrefix(
                      text: '+254',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DefaultInputField(
                    controller:
                        context.watch<CustomerController>().userNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onChange: (p0) {},
                    label: 'Other Details (Optional)',
                    hintText: 'Username',
                    prefix: Image.asset(
                      AppUtil.userNameIcon,
                      package: AppUtil.packageName,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DefaultDropdown(
                    items: const ["Male", "Female", "Other", "None"],
                    itemChild: (value) => DropdownTitle(
                      title: value,
                      color: Theme.of(context).colorScheme.scrim,
                      assetImage: AppUtil.genderIcon,
                    ),
                    onChanged: (value) {
                      try {
                        context.read<CustomerController>().selectedGender =
                            value;
                      } catch (e) {
                        Helpers.debugLog('Something happened :$e');
                      }
                    },
                    hintWidget: DropdownTitle(
                      color: Theme.of(context).colorScheme.scrim,
                      title:
                          context.watch<CustomerController>().selectedGender ??
                              "Gender",
                      assetImage: AppUtil.genderIcon,
                    ),
                    isExpanded: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DefaultInputField(
                    readOnly: true,
                    controller:
                        context.watch<CustomerController>().dobController,
                    onChange: (p0) {},
                    onTap: () {
                      _pickDate(context).then((value) {
                        if (value != null) {
                          context
                                  .read<CustomerController>()
                                  .dobController
                                  .text =
                              DateFormat("EEE, MMM/dd/yyyy").format(value);
                          context.read<CustomerController>().dob = value;
                        }
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Date of Birth is required";
                      }
                      return null;
                    },
                    hintText: 'Date of Birth',
                    prefix: const Icon(Icons.calendar_month),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DefaultInputField(
                    controller:
                        context.watch<LocationController>().locationController,
                    onTap: () {
                      context.read<LocationController>().retainLocation = true;
                      showMap(context);
                    },
                    readOnly: true,
                    onChange: (p0) {},
                    hintText: 'Address',
                    prefix: Image.asset(
                      AppUtil.locationIcon,
                      package: AppUtil.packageName,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DefaultInputField(
                    controller: context
                        .watch<CustomerController>()
                        .descriptionController,
                    onChange: (p0) {},
                    hintText: 'Add a note...',
                    maxLines: 4,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
            ? null
            : context.watch<CustomerController>().uploading
                ? Container(
                    height: 150,
                    color: Colors.white,
                    child: const Center(
                      child: HourGlass(),
                    ),
                  )
                : BottomCard(
                    label: 'Save Customer',
                    onTap: () {
                      context
                          .read<CustomerController>()
                          .addCustomer()
                          .then((value) {
                        if (value) {
                          ShortMessages.showShortMessage(
                            message: "Customer added successfully!.",
                          );

                          context.read<CustomerController>().init();
                          context.read<LocationController>().retainLocation =
                              false;
                          context.read<LocationController>().clear();
                          context.read<CustomerController>().getStoreCustomers(
                              isRefreshMode: true, limit: 10);
                          Navigator.of(context).pop(true);
                        }
                      });
                    },
                  ),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 17),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(DateTime.now().year),
        confirmText: "Apply",
        cancelText: "Cancel",
        initialDatePickerMode: DatePickerMode.day,
        builder: (ctx, child) {
          return Theme(
            data: Theme.of(ctx).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  selectionColor: StyleColors.lukhuBlue70,
                ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                  fixedSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ))),
            child: child!,
          );
        });

    return Future.value(picked);
  }

  void showMap(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return const BlurDialogBody(
          bottomDistance: 80,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AddAddressCard(
              isCustomerAddress: true,
            ),
          ),
        );
      },
    );
  }
}
