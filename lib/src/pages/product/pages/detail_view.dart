// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        ConfirmationCard,
        DefaultBackButton,
        DefaultIconBtn,
        HourGlass,
        InfoCardType,
        LuhkuAppBar,
        NavigationService,
        ReadContext,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/products_controller.dart';
import 'package:sales_pkg/src/pages/product/pages/add_product_view.dart';
import 'package:sales_pkg/src/pages/product/widgets/manage_product/manage_options.dart';
import 'package:sales_pkg/src/widgets/dialogue.dart';

import '../../../controllers/add_item_controller.dart';
import '../../../utils/styles/app_util.dart';
import '../widgets/product_info.dart';
import '../widgets/product_ottom_card.dart';
import '../widgets/sale_card.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});
  static const routeName = 'product_detail';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var productId = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String?>)['productId'];
    var product = context.watch<ProductController>().products[productId];

    return Scaffold(
      appBar: LuhkuAppBar(
        enableShadow: true,
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        title: Text(
          'Product Details',
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DefaultIconBtn(
              packageName: AppUtil.packageName,
              assetImage: AppUtil.trash,
              onTap: () {
                deleteProduct(context, product!.productId!);
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: product == null
            ? const Center(
                child: HourGlass(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SaleCard(
                      product: product,
                      data: product.toJson(),
                      type: ViewType.editView,
                      color: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: ProductInfo(
                      product: product,
                      type: InfoCardType.edit,
                      title: 'Product Info',
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ManageProductOptions(
                        productId: product.productId!,
                      )),
                ],
              ),
      ),
      bottomSheet: ProductBottomCard(
        primaryLabel: 'Share Product',
        primaryLoading: context
            .watch<ProductController>()
            .productLinkIsLoading(productId: product!.productId!),
        onPrimary: () async {
          await context
              .read<ProductController>()
              .shareProuct(productId: product.productId!, context: context);
        },
        secondaryLabel: 'Edit Product',
        onSecondary: () {
          context
              .read<UploadProductController>()
              .initalizeValuesFromExistingProduct(product);
          NavigationService.navigate(context, AddProductView.routeName,
              arguments: product.productId);
        },
      ),
    );
  }

  void deleteProduct(BuildContext context, String productId) {
    Dialogue.blurredDialogue(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ConfirmationCard(
          title: 'Delete Product',
          description: 'Are you sure you want to delete this product?',
          primaryLabel: 'Yes, delete it',
          onPrimaryTap: () {
            context
                .read<ProductController>()
                .deleteProduct(productId: productId);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          color: StyleColors.lukhuError10,
          secondaryLabel: 'Cancel',
          onSecondaryTap: () {
            Navigator.of(context).pop();
          },
          height: 280,
          assetImage: AppUtil.alertCircle,
          packageName: AppUtil.packageName,
          primaryButtonColor: StyleColors.lukhuError,
        ),
      ),
    );
  }
}
