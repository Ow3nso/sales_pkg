import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show DefaultTextBtn, NavigationService, ReadContext, StyleColors;
import 'package:sales_pkg/src/controllers/merchant_controller.dart';

import '../../resource/merchant_resource_view.dart';
import '../../resource/resource_detail.dart';
import 'resource_card.dart';

class ResourceSection extends StatelessWidget {
  const ResourceSection({super.key});

  @override
  Widget build(BuildContext context) {
    var resources = context.read<MerchantController>().resources;
    return Container(
      padding: const EdgeInsets.only(
        top: 13,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Resources 💡️',
                  style: TextStyle(
                    color: StyleColors.lukhuDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                DefaultTextBtn(
                  label: 'See All',
                  onTap: () {
                    NavigationService.navigate(
                      context,
                      MerchantResourceView.routeName,
                    );
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(
                  width: 16,
                ),
                ...List.generate(resources.length, (index) {
                  var resource = resources[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ResourceCard(
                      resource: resource,
                      onTap: () {
                        NavigationService.navigate(
                            context, ResourceDetail.routeName,
                            arguments: {'resource': resources[index]});
                      },
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
