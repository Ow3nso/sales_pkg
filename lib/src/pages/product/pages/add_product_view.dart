// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AddFileCard,
        AppBarType,
        ConfirmationCard,
        DefaultBackButton,
        DefaultIconBtn,
        DefaultInputField,
        DefaultTextBtn,
        HourGlass,
        LuhkuAppBar,
        NavigationService,
        ReadContext,
        ShortMessageType,
        ShortMessages,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/add_item_controller.dart';
import 'package:sales_pkg/src/controllers/products_controller.dart';
import 'package:sales_pkg/src/pages/product/widgets/product_ottom_card.dart';
import 'package:sales_pkg/src/pages/product/widgets/tips_card.dart';
import 'package:sales_pkg/src/widgets/dialogue.dart';

import '../../../utils/styles/app_util.dart';
import '../../../widgets/default_prefix.dart';
import '../widgets/product_info.dart';

enum AddProductType { addProduct, editProduct }

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});
  static const routeName = 'add_product';

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var filesPath = context.watch<UploadProductController>().pickedItemFiles;
    var controller = context.read<UploadProductController>();
    var size = MediaQuery.of(context).size;
    var productId = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: LuhkuAppBar(
        enableShadow: true,
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        color: Theme.of(context).colorScheme.surface,
        title: Text(
          '${productId != null ? "Edit" : "Add"} Product',
          style: TextStyle(
            color: StyleColors.lukhuDark1,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          DefaultIconBtn(
            packageName: AppUtil.packageName,
            assetImage: AppUtil.copyIcon,
            onTap: () {},
          ),
          const SizedBox(width: 24),
          DefaultIconBtn(
            packageName: AppUtil.packageName,
            assetImage: AppUtil.draftIcon,
            onTap: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 24, bottom: 14),
              child: Row(
                children: [
                  Text(
                    '${productId != null ? "Edit" : "Add"} Images and Videos',
                    style: TextStyle(
                        color: StyleColors.lukhuDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  DefaultTextBtn(
                    onTap: () {
                      Dialogue.blurredDialogue(
                          distance: 100,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: TipsCard(),
                          ),
                          context: context);
                    },
                    child: Text(
                      'Photo and Video tips',
                      style: TextStyle(
                        color: StyleColors.lukhuBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(filesPath.length, (index) {
                var path = filesPath[index];
                return Expanded(
                  // height: 58,
                  // width: 58,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AddFileCard(
                      dottedBorderColor: StyleColors.lukhuDark1,
                      onRemoveFile: () {
                        context
                            .read<UploadProductController>()
                            .removeFile(index);
                      },
                      onSelectFile: () {
                        context
                            .read<UploadProductController>()
                            .pickVideoOrImage()
                            .then((image) {
                          if (image != null) {
                            context
                                .read<UploadProductController>()
                                .addPicture(file: image, index: index);
                          }
                        });
                      },
                      mediaPath: path,
                      showBadge: path != null,
                      isVideo: index == filesPath.length - 1,
                    ),
                  ),
                );
              }),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 24),
                      child: DefaultInputField(
                        validator: (s) {
                          if (s!.isEmpty) {
                            return 'Product name is required';
                          }
                          return null;
                        },
                        onChange: (value) {},
                        label: 'Product Name',
                        controller: controller.productNameController,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 24),
                      child: DefaultInputField(
                        validator: (s) {
                          if (s!.isEmpty) {
                            return 'Product description is required';
                          }
                          return null;
                        },
                        onChange: (value) {},
                        label: 'Add Description',
                        hintText: 'Describe your product...',
                        controller: controller.productDescriptionController,
                        maxLines: 3,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: ProductInfo(
                        title: 'Product Info',
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 24),
                      child: DefaultInputField(
                        validator: (s) {
                          if (s!.isEmpty) {
                            return 'Product quantity is required';
                          }
                          return null;
                        },
                        onChange: (value) {},
                        label: 'Quantity',
                        controller: controller.productQuantityController,
                        hintText: '',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 24),
                      child: DefaultInputField(
                        validator: (s) {
                          if (s!.isEmpty) {
                            return 'Product price is required';
                          }
                          return null;
                        },
                        onChange: (value) {},
                        label: 'Price',
                        controller: controller.productPriceController,
                        prefix: const DefaultPrefix(
                          text: 'KSh',
                        ),
                        hintText: '100',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 200,
            )
          ],
        ),
      ),
      bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
          ? null
          : context.watch<UploadProductController>().uploading
              ? Container(
                  height: 150,
                  color: Colors.white,
                  child: const Center(
                    child: HourGlass(),
                  ),
                )
              : ProductBottomCard(
                  primaryLabel:
                      '${productId != null ? "Update" : "Post"} Product',
                  onPrimary: () async {
                    if (filesPath.where((path) => path != null).isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please add at least one image or video'),
                        ),
                      );
                      return;
                    }
                    if (formKey.currentState!.validate()) {
                      try {
                        final uploaded = await context
                            .read<UploadProductController>()
                            .initProduct(
                                originalProduct: context
                                    .read<ProductController>()
                                    .products[productId]);
                        if (uploaded) {
                          final id = context
                              .read<UploadProductController>()
                              .lastProductDocId;
                          context
                              .read<ProductController>()
                              .getProducts(isrefreshMode: true);
                          showUploadConfrimation(context, productId ?? id ?? "",
                              isUpdate: productId != null);
                        }
                      } catch (e) {
                        if (kDebugMode) {
                          log("message: ${e.toString()}",
                              name: "UploadProductPage");
                        }
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Something broke, please try again'),
                        ));
                      }
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all required fields'),
                      ),
                    );
                  },
                  secondaryLabel: 'Save to drafts',
                  onSecondary: () {
                    // if the product has been posted, you can't save it to drafts
                    if (productId != null) {
                      ShortMessages.showShortMessage(
                          type: ShortMessageType.warning,
                          message:
                              "You can't draft a product that has been posted.");
                      return;
                    }
                  },
                ),
    );
  }

  void showUploadConfrimation(BuildContext context, String productId,
      {bool isUpdate = false}) {
    Dialogue.blurredDialogue(
        context: context,
        distance: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConfirmationCard(
            height: 300,
            title: 'Your product has been ${isUpdate ? "updated" : "listed"}!',
            description:
                'Tap below to view your products or share this product with your customers!',
            onPrimaryTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            primaryLabel: 'View Product${!isUpdate ? "s" : ""}',
            secondaryLabel: 'Share this product',
            secondaryLoading: context
                .read<ProductController>()
                .productLinkIsLoading(productId: productId),
            onSecondaryTap: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              await NavigationService.navigatorKey.currentContext!
                  .read<ProductController>()
                  .shareProuct(productId: productId, context: context);
            },
          ),
        ));
  }
}
