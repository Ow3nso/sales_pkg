import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DefaultButton,
        DefaultInputField,
        ReadContext,
        ShortMessageType,
        ShortMessages,
        StringExtension,
        StyleColors,
        UserRepository,
        WatchContext;
import 'package:sales_pkg/src/controllers/service_controller.dart';

import 'store_link_btn.dart';

class StoreContent extends StatelessWidget {
  const StoreContent({super.key, this.index = 0});
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: DefaultInputField(
                controller:
                    context.watch<ServiceController>().storeLinkController,
                onChange: (value) {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                label: 'Current Link',
                suffix: const SizedBox(
                  width: 105,
                  height: 20,
                  child: Row(
                    children: [
                      Expanded(child: VerticalDivider()),
                      Text('.lukhu.shop')
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: StoreLinkButton(),
            ),
            DefaultButton(
              loading: context.watch<ServiceController>().isUploading,
              label: "Submit",
              onTap: context
                      .watch<ServiceController>()
                      .storeLinkController
                      .text
                      .isNotEmpty
                  ? () {
                      if (context
                          .read<ServiceController>()
                          .storeLinkController
                          .text
                          .isEmpty) {
                        return;
                      }
                      _updateStorLink(context);
                    }
                  : null,
              width: MediaQuery.sizeOf(context).width - 32,
              height: 40,
              color: StyleColors.lukhuBlue,
              actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 10),
              child: DefaultInputField(
                controller:
                    context.watch<ServiceController>().storeNameController,
                onChange: (value) {},
                hintText: 'Enter New Store Name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
              ),
            ),
            DefaultButton(
              label: "Save",
              loading: context.watch<ServiceController>().isUploading,
              onTap: context
                      .watch<ServiceController>()
                      .storeNameController
                      .text
                      .isEmpty
                  ? null
                  : () {
                      _updateStoreName(context);
                    },
              width: MediaQuery.sizeOf(context).width - 32,
              color: StyleColors.lukhuBlue,
              height: 40,
              actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
            ),
          ],
        );

      case 2:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 10),
              child: DefaultInputField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller:
                    context.watch<ServiceController>().storeUsernameController,
                onChange: (value) {},
                hintText: 'Enter New Store Username',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: DefaultInputField(
                controller: context
                    .watch<ServiceController>()
                    .storeDescriptionController,
                onChange: (value) {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                hintText: 'Enter New Description...',
                maxLines: 5,
              ),
            ),
            DefaultButton(
              label: "Save",
              loading: context.watch<ServiceController>().isUploading,
              onTap: context.watch<ServiceController>().isUserDescriptionEmpty
                  ? null
                  : () {
                      _updateUsernameAndBio(context);
                    },
              width: MediaQuery.sizeOf(context).width - 32,
              height: 40,
              color: StyleColors.lukhuBlue,
              actionDissabledColor: StyleColors.lukhuDisabledButtonColor,
            ),
          ],
        );
      default:
        return Container();
    }
  }

  void _updateStorLink(BuildContext context) {
    var shop = context.read<UserRepository>().shop;

    context.read<ServiceController>().isUploading = true;

    shop = shop!.copyWith(
      webDomain: context
          .read<ServiceController>()
          .storeLinkController
          .text
          .trim()
          .toLukhuWebLink(),
      requestFreeDomain: context.read<ServiceController>().requestFreeDomain,
    );

    context.read<UserRepository>().updateShop(shop).then((value) {
      context.read<ServiceController>().isUploading = false;
      if (value) {
        var user = context.read<UserRepository>().user;
        user = user!.copyWith(
          userName: context.read<ServiceController>().storeLinkController.text,
        );
        context.read<ServiceController>().storeUsernameController.text =
            user.userName ?? "";
        context.read<UserRepository>().fsUser = user;
        context.read<UserRepository>().updateUser(user);
        context.read<ServiceController>().storeDetails[0]['lable'] =
            shop?.webDomain ?? '';

        ShortMessages.showShortMessage(
          message: 'Store link updated successfully!',
        );
      } else {
        ShortMessages.showShortMessage(
          message: 'Something went wrong, please try again!.',
          type: ShortMessageType.error,
        );
      }
      Navigator.of(context).pop();
    });
  }

  void _updateStoreName(BuildContext context) async {
    context.read<ServiceController>().isUploading = true;
    var shop = context.read<UserRepository>().shop;
    shop = shop!.copyWith(
      name: context.read<ServiceController>().storeNameController.text.trim(),
    );

    context.read<UserRepository>().updateShop(shop).then((value) {
      context.read<ServiceController>().isUploading = false;
      if (value) {
        context.read<ServiceController>().storeDetails[1]['lable'] =
            shop?.name ?? '';
        ShortMessages.showShortMessage(
          message: 'Storename updated successfully uploaded!.',
        );
        // context.read<ServiceController>().setPerformanceValue();
        Navigator.of(context).pop();
      } else {
        ShortMessages.showShortMessage(
          message: 'Something went wrong, please try again!.',
          type: ShortMessageType.error,
        );
      }
    });
  }

  void _updateUsernameAndBio(BuildContext context) {
    context.read<ServiceController>().isUploading = true;
    var shop = context.read<UserRepository>().shop;
    var user = context.read<UserRepository>().user;
    shop = shop!.copyWith(
      description:
          context.read<ServiceController>().storeNameController.text.trim(),
    );

    user = user!.copyWith(
      userName: context.read<ServiceController>().storeUsernameController.text,
    );

    context.read<UserRepository>().updateShop(shop).then((value) {
      context.read<ServiceController>().isUploading = false;
      if (value) {
        var user = context.read<UserRepository>().user;
        user = user!.copyWith(
          userName: context.read<ServiceController>().storeLinkController.text,
          bioDescription: context
              .read<ServiceController>()
              .storeDescriptionController
              .text
              .trim(),
        );
        context.read<UserRepository>().fsUser = user;
        context.read<ServiceController>().storeUsernameController.text =
            user.userName ?? "";
        context.read<ServiceController>().storeDescriptionController.text =
            user.bioDescription ?? "";
        context.read<UserRepository>().updateUser(user);
        ShortMessages.showShortMessage(
          message: 'Store data updated successfully!',
        );
        Navigator.of(context).pop();
      } else {
        ShortMessages.showShortMessage(
          message: 'Something went wrong, please try again!.',
          type: ShortMessageType.error,
        );
      }
    });
  }
}
