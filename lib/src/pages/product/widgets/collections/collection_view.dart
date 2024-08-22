import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show HourGlass, ReadContext, StyleColors, WatchContext;
import 'package:sales_pkg/src/controllers/collection_controller.dart';
import 'package:sales_pkg/src/pages/product/widgets/collections/add_collection.dart';
import 'package:sales_pkg/src/pages/product/widgets/collections/collection_card.dart';
import 'package:sales_pkg/src/widgets/dialogue.dart';

import '../../../../utils/styles/app_util.dart';
import '../../../../widgets/default_message.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    var collections = context.watch<CollectionController>().collections;
    var size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: size.width,
        child: FutureBuilder(
            future: context.read<CollectionController>().getShopCollection(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (collections.isEmpty) {
                  return DefaultMessage(
                    title: 'You don\'t have collections yet',
                    assetImage: AppUtil.folderOpenIcon,
                    color: StyleColors.lukhuError10,
                    description:
                        'Add a collection to your store by tapping the button below',
                    label: 'Add Collection',
                    onTap: () {
                      Dialogue.blurredDialogue(
                        context: context,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: AddCollection(),
                        ),
                      );
                    },
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => context
                      .read<CollectionController>()
                      .getShopCollection(isRefresh: true),
                  child: ListView.builder(
                    itemCount: collections.length,
                    padding: const EdgeInsets.only(top: 15),
                    itemBuilder: (BuildContext context, int index) {
                      return CollectionCard(
                        shopCollection:
                            collections[collections.keys.elementAt(index)]!,
                      );
                    },
                  ),
                );
              }

              return const Center(child: HourGlass());
            }));
  }
}
