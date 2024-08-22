import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';

class ReviewItems extends StatelessWidget {
  const ReviewItems({super.key});
  static const routeName = 'review-items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LuhkuAppBar(
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        enableShadow: true,
        color: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Review your items',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DefaultCallBtn(),
          ),
        ],
      ),
    );
  }
}
