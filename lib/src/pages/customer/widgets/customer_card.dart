import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard(
      {super.key, required this.data, this.onTap, required this.customer});
  final Map<String, dynamic> data;
  final void Function(Customer)? onTap;
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(customer);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ))),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: StyleColors.lukhuBlue50,
              child: Icon(Icons.account_circle_outlined,
                  color: Theme.of(context).colorScheme.surface),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    customer.phoneNumber!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
