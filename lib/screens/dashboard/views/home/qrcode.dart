import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../utils/utils.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key, required this.qrData});
  final String qrData;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Hero(
          tag: "card",
          child: Material(
            color: Colors.white,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: Get.width * 0.7,
              height: Get.width * 0.7,
              child: Stack(
                children: [
                  Center(
                    child: QrImageView(
                      dataModuleStyle: const QrDataModuleStyle(
                          color: Colors.black,
                          dataModuleShape: QrDataModuleShape.circle),
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                      eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.circle,
                          color: AppColors.primaryColor),
                      embeddedImageStyle:
                          const QrEmbeddedImageStyle(size: Size(60, 50)),
                      embeddedImage: AssetImage(logo),
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                    ).p(20),
                  ),
                ],
              ),
            ),
          ),
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
        ),
      ),
    );
  }
}
