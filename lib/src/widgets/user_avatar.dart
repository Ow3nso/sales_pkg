import 'package:flutter/material.dart' hide Badge;
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show StyleColors;

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.isOnline = false, this.image});
  final bool isOnline;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: StyleColors.pink,
          //backgroundImage: image == null ? null : NetworkImage(image!),
          radius: 25,
          child: image == null
              ? Icon(
                  Icons.person,
                  color: StyleColors.lukhuWhite,
                )
              : null,
        ),
        if (isOnline)
          Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              height: 15,
              width: 15,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: StyleColors.lukhuWhite,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: StyleColors.lukhuSuccess200,
              ),
            ),
          )
      ],
    );
  }
}
