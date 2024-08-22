import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show BlurDialogBody;

class Dialogue {
  static Future<void> blurredDialogue({
    required Widget child,
    required BuildContext context,
    double distance = 80,
  }) async {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (ctx) {
        return BlurDialogBody(
          bottomDistance: distance,
          child: child,
        );
      },
    );
  }
}
