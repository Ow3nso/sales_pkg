import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show CircularCheckbox, ReadContext, StyleColors, WatchContext;
import 'package:sales_pkg/src/controllers/service_controller.dart';

class StoreLinkButton extends StatelessWidget {
  const StoreLinkButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ServiceController>().requestFreeDomain =
            !context.read<ServiceController>().requestFreeDomain;
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: context.watch<ServiceController>().requestFreeDomain
              ? StyleColors.lukhuBlue10
              : null,
          border: Border.all(
            color: StyleColors.lukhuDividerColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircularCheckbox(
                isChecked: context.watch<ServiceController>().requestFreeDomain,
              ),
            ),
            Text.rich(TextSpan(
                text: 'Request for a free ',
                style: TextStyle(
                  color: StyleColors.lukhuDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    style: TextStyle(
                      color: StyleColors.lukhuDark1,
                      fontWeight: FontWeight.w700,
                    ),
                    text: '.co.ke ',
                  ),
                  const TextSpan(text: 'domain')
                ]))
          ],
        ),
      ),
    );
  }
}
