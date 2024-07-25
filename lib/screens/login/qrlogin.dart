import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeLoginScreen extends StatefulWidget {
  const QrCodeLoginScreen({super.key});

  @override
  State<QrCodeLoginScreen> createState() => _QrCodeLoginScreenState();
}

class _QrCodeLoginScreenState extends State<QrCodeLoginScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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
      body: Center(
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
                          border: Border.all(color: Colors.yellow, width: 2),
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
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        log(result!.code!);
      });
    });
  }

  void handleLogin(String qrCodeData) {
    bool loginSuccessful = _authenticateWithServer(qrCodeData);

    if (loginSuccessful) {
      // TODO Redirect to homepage after login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  bool _authenticateWithServer(String qrCodeData) {
    return qrCodeData == "valid_token"; // Replace with your own logic
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
