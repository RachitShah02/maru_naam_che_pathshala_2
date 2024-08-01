import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/screens.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeLoginScreen extends StatefulWidget {
  const QrCodeLoginScreen({super.key});

  @override
  State<QrCodeLoginScreen> createState() => _QrCodeLoginScreenState();
}

class _QrCodeLoginScreenState extends State<QrCodeLoginScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? result;
  QRViewController? controller;
  bool isLogin = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.black),
              width: Get.width * .80,
              height: Get.height * .50,
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: QRView(
                            overlay: QrScannerOverlayShape(borderRadius: 20),
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.yellow, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const Positioned(
                            top: 5,
                            right: 5,
                            child: CloseButton(
                              color: Colors.amber,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isLogin,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code!.startsWith("MNP")) {
        controller.stopCamera();
        handleLogin(scanData.code!);
      } else {
        controller.resumeCamera();
      }
    });
  }

  void handleLogin(String qrCodeData) async {
    setState(() {
      isLogin = true;
    });
    box.write(Keys.sid, qrCodeData);
    final data = await ApiService.getData(endPoint: 'login');
    final result = studentModelFromJson(data);
    if (result.sid == qrCodeData) {
      List<StudentModel> studentList = [];
      String? oldList = box.read(Keys.studentList);
      if (oldList != null && oldList.isNotEmpty) {
        studentList = studentModelListFromJson(oldList);
      }
      studentList.add(result);
      box.write(Keys.studentList, studentModelListToJson(studentList));
      customSnackBar(
        title: "Alert",
        message: "Login Successful",
        type: SnackBarType.success,
      );
      Get.offAll(() => const DashBoardScreen(),
          transition: Transition.leftToRight);
    } else {
      box.write(Keys.sid, '');
      customSnackBar(
          title: "Alert",
          message: "Invalid MNP ID",
          callback: () {
            controller!.resumeCamera();
          });

      setState(() {
        isLogin = false;
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
