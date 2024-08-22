import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show AppBarType, DefaultBackButton, DefaultIconBtn, ImageCard, LuhkuAppBar;

import '../../utils/styles/app_util.dart';

class ResourceDetail extends StatelessWidget {
  const ResourceDetail({super.key});
  static const routeName = 'resource_detail';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var resource = args['resource'] as Map<String, dynamic>;
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
        child: ListView(
          children: [
            SizedBox(
              height: 123,
              width: size.width,
              child: ImageCard(
                image: resource['image'],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: Text(
                resource['title'],
                style: TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      resource['description'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.scrim,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
