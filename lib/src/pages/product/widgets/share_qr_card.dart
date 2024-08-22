import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        DefaultButton,
        QrDataModuleShape,
        QrDataModuleStyle,
        QrEyeShape,
        QrEyeStyle,
        QrImageView,
        Share,
        StyleColors;
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class ShareQrCard extends StatelessWidget {
  const ShareQrCard({
    super.key,
    required this.productUrl,
    this.title,
    this.description,
  });
  final String productUrl;
  final String? title, description;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 615,
      width: size.width,
      decoration: BoxDecoration(
        color: StyleColors.lukhuWhite,
        border: Border.all(color: StyleColors.lukhuDividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: StyleColors.lukhuBlue0,
            radius: 30,
            child: CircleAvatar(
              backgroundColor: StyleColors.lukhuBlue10,
              child: Image.asset(
                AppUtil.barcodeIcon,
                package: AppUtil.packageName,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              title ?? 'Scan the Code to order',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
          Text(
            description ??
                'Ask the customer to scan the QR code using their phone or send them the product link',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: StyleColors.lukhuGrey80,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Container(
              height: 280,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                  color: StyleColors.lukhuBlue0,
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Center(
                  child: QrImageView(
                    eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.circle,
                        color: Theme.of(context).colorScheme.inverseSurface),
                    dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.circle,
                        color: Theme.of(context).colorScheme.inverseSurface),
                    errorStateBuilder: (context, error) => Text(
                      'Seems like there is an error',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.scrim,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    data: productUrl,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          DefaultButton(
            label: 'Share Link',
            height: 40,
            onTap: () {
              Navigator.of(context).pop();
              Share.share(productUrl);
            },
            color: StyleColors.lukhuBlue,
            width: size.width - 32,
          ),
          const SizedBox(height: 12),
          DefaultButton(
            label: 'Cancel',
            height: 40,
            onTap: () {
              Navigator.of(context).pop();
            },
            color: Theme.of(context).colorScheme.onPrimary,
            textColor: Theme.of(context).colorScheme.scrim,
            boarderColor: StyleColors.lukhuDividerColor,
            width: size.width - 32,
          )
        ],
      ),
    );
  }
}
