
import 'package:flutter/material.dart';

import 'sizes_selection_card.dart';


class SizeSelectionView extends StatelessWidget {
  const SizeSelectionView(
      {super.key, required this.category,});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedSelectionCard(
              asseticon: 'assets/icons/top_icon.png',
                category: category,
                title: 'Tops'),
            
            SizedSelectionCard(
              asseticon: 'assets/icons/bottoms_icon.png',
                category: category,
                title: 'Bottoms'),
          ],
        ),
      ),
    );
  }
}
