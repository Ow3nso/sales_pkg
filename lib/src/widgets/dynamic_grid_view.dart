import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart';

class DynamicImageGridView extends StatelessWidget {
  final List<String> imageUrls;
  final double gridWidth;
  final double gridHeight;

  const DynamicImageGridView({super.key, 
    required this.imageUrls,
    required this.gridWidth,
    required this.gridHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: gridWidth,
      height: gridHeight,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate the optimal number of columns based on the number of images and the available width
          int crossAxisCount = (constraints.maxWidth /
                  (constraints.maxWidth /
                      (imageUrls.length <= 4 ? imageUrls.length : 4)))
              .floor();


          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: .9,
               // Set the calculated mainAxisSpacing
            ),
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index) {
              return AspectRatio(
                aspectRatio: 1.0,
                child: ImageCard(image: imageUrls[index],fit: BoxFit.cover),
              );
            },
          );
        },
      ),
    );
  }
}
