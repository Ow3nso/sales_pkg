import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        DefaultBackButton,
        DefaultIconBtn,
        LuhkuAppBar,
        NavigationService,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/collection_controller.dart';
import 'package:sales_pkg/src/controllers/products_controller.dart';
import 'package:sales_pkg/src/pages/product/widgets/product_card_view.dart';

import '../../../utils/styles/app_util.dart';
import '../../../widgets/bottom_card.dart';
import '../../../widgets/dialogue.dart';
import '../widgets/collections/add_collection.dart';
import '../widgets/collections/collection_view.dart';
import 'add_product_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});
  static const routeName = 'products_view';

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int _selectedIndex = 0;
  void _setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var hasCollections = context.watch<CollectionController>().hasCollections;
    var hasProducts = context.watch<ProductController>().products.isNotEmpty;
    var args = ModalRoute.of(context)!.settings.arguments;
    final showButton = args != null;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: LuhkuAppBar(
          enableShadow: true,
          bottomHeight: kTextTabBarHeight,
          appBarType: AppBarType.other,
          backAction: showButton ? const DefaultBackButton() : null,
          title: Text(
            'Your Products',
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
                assetImage: AppUtil.documentTextIcon,
                onTap: () {},
              ),
            ),
          ],
          bottom: TabBar(
            onTap: (value) => _setIndex(value),
            indicatorColor: StyleColors.lukhuDark,
            labelColor: StyleColors.lukhuDark,
            labelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            unselectedLabelColor: StyleColors.lukhuDark,
            unselectedLabelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            tabs: const [
              Tab(
                text: 'Products',
              ),
              Tab(
                text: 'Collections',
              ),
            ],
          ),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [ProductsCard(), CollectionView()]),
        ),
        bottomSheet: ((hasProducts && _selectedIndex == 0) ||
                (hasCollections && _selectedIndex == 1))
            ? BottomCard(
                onTap: () {
                  if (_selectedIndex == 0) {
                    NavigationService.navigate(
                      context,
                      AddProductView.routeName,
                    );
                  } else {
                    Dialogue.blurredDialogue(
                      context: context,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: AddCollection(),
                      ),
                    );
                  }
                },
                label: _selectedIndex == 0 ? 'Add Product' : 'Add Collection',
              )
            : null,
      ),
    );
  }
}
