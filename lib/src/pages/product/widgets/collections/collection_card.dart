import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DefaultTextBtn,
        NavigationService,
        ReadContext,
        ShopCollection,
        ShortMessages,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/pages/product/pages/product_collection_view.dart';

import '../../../../controllers/collection_controller.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({super.key, required this.shopCollection});
  final ShopCollection shopCollection;

  @override
  Widget build(BuildContext context) {
    return InkWell(            
      onTap: () {
        NavigationService.navigate(context, ProductCollectionView.routeName,
            arguments: shopCollection);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: StyleColors.lukhuDividerColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shopCollection.name!,
                  style: TextStyle(
                      color: StyleColors.gray90,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                Text(
                  '${shopCollection.productIds!.length} Products',
                  style: TextStyle(
                      color: StyleColors.lukhuGrey70,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            DefaultTextBtn(
              onTap: () async {
                if (context
                    .read<CollectionController>()
                    .hasCollectionBeingShared) {
                  ShortMessages.showShortMessage(
                      message:
                          "Please wait for the current collection to finish sharing");
                  return;
                }
                context.read<CollectionController>().shareCollectionLink(
                    context: context, shopCollection: shopCollection);
              
              },
              child: context
                      .watch<CollectionController>()
                      .collectionIsBeingShared(shopCollection.docId!)
                  ? Center(
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              StyleColors.lukhuBlue),
                        ),
                      ),
                    )
                  : Text(
                      'Share Link',
                      style: TextStyle(
                          color: StyleColors.lukhuBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: StyleColors.lukhuDark1,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
