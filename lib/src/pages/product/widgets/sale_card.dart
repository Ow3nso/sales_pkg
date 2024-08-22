import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        CartController,
        DefaultDropdown,
        FilterColorText,
        Product,
        QuantityAdjustBtn,
        ReadContext,
        StyleColors,
        WatchContext;
// import 'package:sales_pkg/src/controllers/add_item_controller.dart';
import 'package:sales_pkg/src/controllers/products_controller.dart';
import 'package:sales_pkg/src/pages/product/widgets/sale_detail.dart';

enum ViewType { saleView, productView, editView }

class SaleCard extends StatelessWidget {
  const SaleCard(
      {super.key,
      required this.data,
      this.color,
      this.type = ViewType.saleView,
      this.onTap,
      this.isAddedToCart = false,
      this.product});
  final Map<String, dynamic> data;
  final Color? color;
  final ViewType type;
  final void Function()? onTap;
  final Product? product;
  final bool isAddedToCart;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var filterColors = context.watch<UploadProductController>().filterColors;
    // var selectedFilter =
    //     context.read<UploadProductController>().selectedFilteredColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: color ?? StyleColors.lukhuWhite,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            SaleDetail(
              product: product,
              data: data,
              type: type,
              isAddedToCart: isAddedToCart,
              alignment: isAddedToCart
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
            ),
            if (isAddedToCart)
              Column(
                children: [
                  Divider(
                    color: StyleColors.lukhuDividerColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        child: DefaultDropdown(
                          itemChild: (value) => FilterColorText(
                            color: value['color'],
                            value: value['name'],
                          ),
                          hintWidget: FilterColorText(
                            color: context
                                .watch<ProductController>()
                                .getProductColor(
                                  product,
                                  context
                                      .watch<CartController>()
                                      .cartColors[product!.productId],
                                ),
                            value: context
                                    .watch<CartController>()
                                    .cartColors[product!.productId] ??
                                "Color",
                          ),
                          onChanged: (value) {
                            context.read<ProductController>().selectedColor =
                                value!['name'];
                            context
                                    .read<CartController>()
                                    .cartColors[product!.productId!] =
                                value['name'] ?? "";
                          },
                          items: context
                              .watch<ProductController>()
                              .optionColors(product),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: DefaultDropdown(
                          itemChild: (value) => Text(value),
                          hintWidget: Text(context
                                  .watch<CartController>()
                                  .cartSizes[product!.productId!] ??
                              "Size"),
                          onChanged: (value) {
                            context
                                .read<CartController>()
                                .cartSizes[product!.productId!] = value ?? "";
                          },
                          items: product!.availableSizes!,
                        ),
                      ),
                      QuantityAdjustBtn(
                        onAddQuantity: () {
                          context
                              .read<CartController>()
                              .updateCart(value: product!, addProduct: true);
                        },
                        quantity: context
                            .watch<CartController>()
                            .getCartQuantity(product!.productId!),
                        onMinusQuantity: () {
                          context
                              .read<CartController>()
                              .updateCart(value: product!);
                        },
                      )
                    ],
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
