import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maru_naam_che_pathshala_2/utils/custom_rect_tween.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class IdCardScreen extends StatelessWidget {
  const IdCardScreen({super.key, required this.qrData});
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
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ).p(20), // TODO : ID CARD
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
