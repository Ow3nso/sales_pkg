// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show BlurDialogBody, InfoCardType, Product, ReadContext, WatchContext;
import 'package:sales_pkg/src/pages/product/widgets/product_info/info_pop_up_card.dart';
import 'package:sales_pkg/src/pages/product/widgets/product_info/category_options_card.dart';
import 'package:sales_pkg/src/pages/product/widgets/product_info/product_info_action_btn.dart';
import 'package:sales_pkg/src/pages/product/widgets/product_info/sizes_selection_card.dart';

import '../../../controllers/add_item_controller.dart';
import '../../../utils/styles/app_util.dart';
import 'color_selection/colors_selection_card.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo(
      {super.key,

      this.title = '',
      this.type = InfoCardType.add,
      this.onTap,
      this.product});

  final String title;
  final InfoCardType type;
  final void Function()? onTap;
  final Product? product;

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    const int maxSizeDisplay = 6;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ProductInfoButton(
            showAction: !_isDetailsMode,
            listPosition: 0,
            title: "Category",
            value: widget.product?.category ??
                context.read<UploadProductController>().category,
            onTap: _isDetailsMode
                ? null
                : () {
                  _unfocus(context);
                    _showCategoryOptions(context);
                  }),
        if (context.read<UploadProductController>().category != null ||
            _isDetailsMode)
          ProductInfoButton(
              showAction: !_isDetailsMode,
              listPosition: 1,
              title: "Size",
              value: _isDetailsMode
                  ? _getSizes(maxSizeDisplay, widget.product!.availableSizes!)
                  : context.watch<UploadProductController>().sizes.isEmpty
                      ? null
                      : _getSizes(maxSizeDisplay, context.read<UploadProductController>().sizes),
              onTap: _isDetailsMode
                  ? null
                  : () {
                     _unfocus(context);
                      _showSizesOptions(context);
                    }),
        ProductInfoButton(
           showAction: !_isDetailsMode,
            listPosition: 2,
            title: 'Condition',
            value: widget.product?.subCategory?? context.read<UploadProductController>().condition,
            onTap: _isDetailsMode? null: () {
              _showConditionOptions(context);
            }),
        ProductInfoButton(
          showAction: !_isDetailsMode,
            listPosition: 3,
            title: 'Color',
            value: _isDetailsMode? _getSizes(maxSizeDisplay, widget.product!.availableColors!) :context
                    .watch<UploadProductController>()
                    .selectedColors
                    .isEmpty
                ? null
                : _getSizes(maxSizeDisplay, context.read<UploadProductController>().selectedColors.toList()),
            onTap: () {
               _unfocus(context);
              _showColorsOptions(context);
            }),
        if(_isDetailsMode)
          ProductInfoButton(
            showAction: !_isDetailsMode,
            title: "Quantity", value: widget.product!.stock.toString(), onTap: null, listPosition: 4)
      ],
    );
  }

  void _unfocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
  }

  String _getSizes(int maxSizeDisplay,List<String> sizes) {
    return sizes.length < maxSizeDisplay
        ? sizes.join(',')
        : '${sizes.sublist(0, maxSizeDisplay - 1).join(',')} +${sizes.length - (maxSizeDisplay - 1)} more';
  }

  bool get _isDetailsMode => widget.product != null;

  /// It shows a dialog with a list of options.
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget that calls the function.
  ///
  /// Returns:
  ///   A dialog box is being returned.
  void _showCategoryOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => BlurDialogBody(
              child: InfoPopUpCard(
                  onSave: () {
                    if (context.read<UploadProductController>().category ==
                        null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a category'),
                        ),
                      );
                      return;
                    }
                  },
                  height: 375,
                  title: 'Category',
                  child: InfoOptionsCard(
                      onSelected: (value) {
                        context.read<UploadProductController>().category =
                            value;
                        Navigator.pop(context);
                      },
                      options:
                          AppUtil.productInfoData['category'] as List<String>)),
            ));
  }

  /// It shows a dialog with a list of options for the user to select from.
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget that calls the function.
  ///
  /// Returns:
  ///   A BlurDialogBody widget.
  void _showConditionOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => BlurDialogBody(
              child: InfoPopUpCard(
                  height: 375,
                  title: 'Condition',
                  onSave: () {
                    if (context.read<UploadProductController>().condition ==
                        null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a condition'),
                        ),
                      );
                      return;
                    }
                  },
                  child: InfoOptionsCard(
                      onSelected: (value) {
                        context.read<UploadProductController>().condition =
                            value;
                        Navigator.pop(context);
                      },
                      options: AppUtil.productInfoData['condition']
                          as List<String>)),
            ));
  }

  /// It shows a dialog with a card that has a title, a save button, and a child
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget that calls the function.
  ///
  /// Returns:
  ///   A BlurDialogBody widget.
  void _showSizesOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => BlurDialogBody(
              child: InfoPopUpCard(
                  height:
                      context.watch<UploadProductController>().sizePopUpHeight,
                  title:
                      "${context.read<UploadProductController>().category}'s Sizes",
                  onSave: () {
                    if (context.read<UploadProductController>().sizes.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a size'),
                        ),
                      );
                      return;
                    }
                  },
                  child: const SizesSelectionCard()),
            ));
  }

  void _showColorsOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => BlurDialogBody(
              child: InfoPopUpCard(
                  title: "Colors",
                  onSave: () {
                    if (context
                        .read<UploadProductController>()
                        .selectedColors
                        .isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a color'),
                        ),
                      );
                      return;
                    }
                  },
                  child: const ColorsSelectionCard()),
            ));
  }
}
