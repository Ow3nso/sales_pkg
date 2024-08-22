import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        LuhkuAppBar,
        DefaultBackButton,
        AppBarType,
        ReadContext,
        DefaultIconBtn,
        NavigationService;
import 'package:sales_pkg/src/controllers/merchant_controller.dart';
import 'package:sales_pkg/src/pages/seller/widgets/resource_card.dart';
import 'package:sales_pkg/src/utils/styles/app_util.dart';

import 'resource_detail.dart';

class MerchantResourceView extends StatelessWidget {
  const MerchantResourceView({super.key});
  static const routeName = 'merchant_resource';

  @override
  Widget build(BuildContext context) {
    var resources = context.read<MerchantController>().resources;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: LuhkuAppBar(
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        centerTitle: true,
        enableShadow: true,
        height: 85,
        color: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Market Resources',
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: DefaultIconBtn(
                assetImage: AppUtil.sendImageIcon,
                packageName: AppUtil.packageName,
                onTap: () {},
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      MediaQuery.of(context).size.width < 384 ? .6 : 1.1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 1,
                ),
                itemCount: resources.length,
                itemBuilder: (context, index) => ResourceCard(
                  resource: resources[index],
                  onTap: () {
                    NavigationService.navigate(
                        context, ResourceDetail.routeName,
                        arguments: {'resource': resources[index]});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
