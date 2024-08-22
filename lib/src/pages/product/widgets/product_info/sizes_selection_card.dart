import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultCheckbox, ReadContext, StyleColors, WatchContext;
import '../../../../controllers/add_item_controller.dart';
import '../sizes_selection/sizes_selection_card.dart';

class SizesSelectionCard extends StatefulWidget {
  const SizesSelectionCard({super.key});

  @override
  State<SizesSelectionCard> createState() => _SizesSelectionCardState();
}

class _SizesSelectionCardState extends State<SizesSelectionCard> {
  final double defaultHeight = 430;
  final double isAvailableInVariousSizesHeight = 260;
  final Map<String, GlobalKey> expansionTileKeys = {
    "Tops": GlobalKey(),
    "Bottoms": GlobalKey(),
    "Footwear": GlobalKey(),
  };
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BorderLineCover(
            child: DefaultCheckbox(
          title: Text(
            "Available in Various Sizes",
            style: TextStyle(
                color: StyleColors.lukhuDark, fontWeight: FontWeight.w600),
          ),
          value:
              context.watch<UploadProductController>().isVailableInVariousSizes,
          onChanged: (v) {
            context.read<UploadProductController>().isVailableInVariousSizes =
                v ?? false;
            if (v ?? false) {
              context.read<UploadProductController>().sizePopUpHeight =
                  isAvailableInVariousSizesHeight;
              return;
            }
            context.read<UploadProductController>().sizePopUpHeight =
                defaultHeight;
          },
        )),
        if (!context.watch<UploadProductController>().isVailableInVariousSizes)
          Column(
            children: [
              BorderLineCover(
                  child: ExpansionTile(
                key: expansionTileKeys["Tops"],
                onExpansionChanged: (value) {
                  onExpansionChanged(value, context, expansionTileKeys, "Tops");
                },
                textColor: StyleColors.lukhuDark,
                title: const Text('Tops'),
                children: [
                  SizedSelectionCard(
                    title: "Tops",
                    category: context.read<UploadProductController>().category!,
                    asseticon: "assets/icons/top_icon.png",
                  ),
                ],
              )),
              BorderLineCover(
                  child: ExpansionTile(
                key: expansionTileKeys["Bottoms"],
                onExpansionChanged: (value) {
                  onExpansionChanged(
                      value, context, expansionTileKeys, "Bottoms");
                },
                textColor: StyleColors.lukhuDark,
                title: const Text('Bottoms'),
                children: [
                  SizedSelectionCard(
                    title: "Bottoms",
                    category: context.read<UploadProductController>().category!,
                    asseticon: "assets/icons/bottoms_icon.png",
                  ),
                ],
              )),
              BorderLineCover(
                  child: ExpansionTile(
                key: expansionTileKeys["Footwear"],
                onExpansionChanged: (value) {
                  onExpansionChanged(
                      value, context, expansionTileKeys, "Footwear");
                },
                textColor: StyleColors.lukhuDark,
                title: const Text('Footwear'),
                children: [
                  SizedSelectionCard(
                    title: "Shoes",
                    category: context.read<UploadProductController>().category!,
                    asseticon: "assets/icons/bottoms_icon.png",
                  ),
                ],
              )),
            ],
          )
      ],
    );
  }

  /// A function that is called when the user clicks on the expandable widget. It is used to change the
  /// height of the popup.
  ///
  /// Args:
  ///   value (bool): The value of the expansion tile.
  ///   context (BuildContext): The context of the widget.
  ///
  /// Returns:
  ///   A function that takes in a bool and a BuildContext.
  void onExpansionChanged(bool value, BuildContext context,
      Map<String, GlobalKey> expansionTileKeys, String key) {
    expansionTileKeys.forEach((k, v) {
      if (k != key) {
        expansionTileKeys[k] = GlobalKey();
        setState(() {
          
        });
      }
    });
    if (value) {
      context.read<UploadProductController>().sizePopUpHeight = 430 * 1.5;
      return;
    }
    context.read<UploadProductController>().sizePopUpHeight = 430;
  }
}

class BorderLineCover extends StatelessWidget {
  const BorderLineCover({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: StyleColors.lukhuDividerColor),
          top: BorderSide(
            color: StyleColors.lukhuDividerColor,
          ),
        ),
      ),
      child: child,
    );
  }
}
