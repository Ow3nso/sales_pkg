import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AddToBagBtn,
        CartController,
        ImageCard,
        Product,
        ReadContext,
        StyleColors;
import 'package:sales_pkg/src/pages/product/widgets/sale_card.dart';
import 'sale_text.dart';

class SaleDetail extends StatelessWidget {
  const SaleDetail(
      {super.key,
      required this.data,
      this.type = ViewType.saleView,
      required this.alignment,
      this.isAddedToCart = false,
      this.product});
  final Map<String, dynamic> data;
  final ViewType type;
  final CrossAxisAlignment alignment;
  final Product? product;
  final bool isAddedToCart;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: alignment,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ImageCard(
              image: product?.images?.first ?? data['image'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product?.label ?? data['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: StyleColors.lukhuDark1,
                      ),
                    ),
                  ),
                  if (type == ViewType.productView)
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Theme.of(context).colorScheme.scrim)
                ],
              ),
              if (type != ViewType.editView)
                SaleText(
                  title: 'Size:',
                  description:
                      product?.availableSizes?.join(',') ?? data['size'],
                ),
              Row(
                children: [
                  Text(
                    'KSh ${product?.price ?? data['price']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: StyleColors.lukhuDark1,
                    ),
                  ),
                  const Spacer(),
                  if (type == ViewType.saleView)
                    AddToBagBtn(
                        activeCart: isAddedToCart,
                        onTap: () {
                          context.read<CartController>().addToCart(product!);
                        })
                ],
              ),
              if (type == ViewType.editView)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SaleText(
                        title: 'Liked: ',
                        description: product?.likes?.length.toString() ??
                            data['liked'].toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SaleText(
                        title: 'Item Views: ',
                        description: product?.views?.length.toString() ??
                            data['views'].toString(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: SaleText(
                        title: 'Offers: ',
                        description: '0',
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 25,
              ),
              if (type == ViewType.productView)
                SaleText(
                  title: 'Quantity:',
                  description:
                      product?.stock.toString() ?? data['quantity'].toString(),
                ),
            ],
          ),
        )
      ],
    );
  }
}
