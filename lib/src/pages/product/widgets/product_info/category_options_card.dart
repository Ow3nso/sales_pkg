import 'package:flutter/material.dart';

import 'package:sales_pkg/src/pages/product/widgets/product_info/product_info_action_btn.dart';

/// `CategoryOptionsCard` is a `StatelessWidget` that displays a `ListView` of `ProductInfoButton`s

class InfoOptionsCard extends StatelessWidget {
  const InfoOptionsCard(
      {super.key, required this.options, required this.onSelected});
  /// The list of options to display.
  final List<String> options;
  /// Unfolds the value of the current selected itm.
  final void Function(String? value) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...List.generate(
            options.length,
            (i) => ProductInfoButton(
                title: options[i],
                value: '',
                onTap: () {
                  onSelected(options[i]);
                },
                listPosition: i))
      ],
    );
  }
}
