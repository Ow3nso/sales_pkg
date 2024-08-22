import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show StyleColors;

class ResourceCard extends StatelessWidget {
  const ResourceCard({
    super.key,
    required this.resource,
    this.onTap,
  });

  final Map<String, dynamic> resource;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: StyleColors.lukhuWhite),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(resource['image'], fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: Text(
                resource['title'],
                style: TextStyle(
                  color: StyleColors.lukhuDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
