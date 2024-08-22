import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        CircularCheckbox,
        DiscountCard,
        ImageCard,
        Product,
        StyleColors;

import '../utils/styles/app_util.dart';

enum ProductType { discount, setDiscount, product,selectable }

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key, this.onTap, this.type = ProductType.discount, this.product,this.isSelected = false,this.onLongPress});
  final void Function()? onTap;
  final ProductType type;
  final Product? product;
  final bool isSelected;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(
            height: 120,
            width: 115,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ImageCard(
                image: product != null
                    ? product!.images!.first
                    : "https://images.unsplash.com/photo-1610000000000-000000000000?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (type == ProductType.selectable )
            Positioned(
              top: 2,
              left: 2,
              child: CircularCheckbox(
                onTap: onTap,
                isChecked: isSelected,
              ),
            ),
          if ((type == ProductType.discount || type == ProductType.product) &&
              (product?.isOnDiscount ?? false))
            Positioned(
              bottom: 5,
              right: 10,
              child: DiscountCard(
                color: Theme.of(context).colorScheme.onPrimary,
                iconImage: AppUtil.discountIcon,
                packageName: AppUtil.packageName,
                description: getDiscoountText(product!),
              ),
            ),
          if (product?.isSoldOut ?? false)
            Positioned(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: StyleColors.lukhuDark.withOpacity(.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'SOLD',
                  style: TextStyle(
                    color: StyleColors.lukhuWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  String getDiscoountText(Product product) {
    if ((product.discountPercentage ?? 0) > 0) {
      return '${product.discountPercentage?.round()}% Off';
    } else {
      return 'KES ${product.discountAmount?.round()} Off';
    }
  }
}
