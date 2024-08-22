import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultButton, DefaultInputField, ReadContext, StyleColors;
import 'package:sales_pkg/src/controllers/collection_controller.dart';

class AddCollection extends StatelessWidget {
  const AddCollection({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: size.width,
        height: 270,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(
            color: StyleColors.lukhuDividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              'Add a collection',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: StyleColors.lukhuDark1,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 23, top: 16),
              child: DefaultInputField(
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (s){
                  context.read<CollectionController>().addCollection();
                  Navigator.of(context).pop();
                },
                onChange: (p0) {},
                hintText: 'Collection',
                controller:
                    context.read<CollectionController>().nameTextController,
              ),
            ),
            DefaultButton(
              label: 'Save Collection',
              onTap: () {
                context.read<CollectionController>().addCollection();
                Navigator.of(context).pop();
              },
              color: StyleColors.lukhuBlue,
              width: size.width - 32,
              textColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 12),
            DefaultButton(
              label: 'Cancel',
              onTap: () {
                Navigator.of(context).pop();
              },
              boarderColor: StyleColors.lukhuDividerColor,
              width: size.width - 32,
              textColor: Theme.of(context).colorScheme.scrim,
            ),
          ],
        ),
      ),
    );
  }
}
