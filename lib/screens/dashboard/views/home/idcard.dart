import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class IdcardScreen extends StatefulWidget {
  const IdcardScreen({super.key});

  @override
  State<IdcardScreen> createState() => _IdcardScreenState();
}

class _IdcardScreenState extends State<IdcardScreen> {
  String studentname = '', mobile = '', pathshala = '';
  final screenshotController = ScreenshotController();
  final TransformationController _transformationController =
      TransformationController();

  void _resetZoom() {
    // Reset the transformation to the default (identity matrix)
    _transformationController.value = Matrix4.identity();
  }

  @override
  void initState() {
    super.initState();
    List<StudentModel> studentList = filterStudents();
    studentname = studentList[0].fullName!;
    pathshala = studentList[0].pathshala!;
    mobile = studentList[0].mo1!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My ID Card".text.make(),
        actions: [
          IconButton(
              onPressed: () async {
                _resetZoom();
                final imageFile = await screenshotController.capture();
                if (imageFile != null) {
                  final result = await ImageGallerySaver.saveImage(imageFile);
                  bool isSuccess = result['isSuccess'] as bool;
                  if (isSuccess) {
                    customSnackBar(
                        title: "Sucess",
                        message: "ID Card Saved To Gallery's Album Folder",
                        type: SnackBarType.success);
                  }
                }
              },
              icon: const Icon(FontAwesomeIcons.download)),
          IconButton(
              onPressed: () async {
                _resetZoom();
                final imageFile = await screenshotController.capture();
                final dir = await getApplicationDocumentsDirectory();
                final image =
                    File('${dir.path}/idcard_${box.read(Keys.sid)}.png');
                image.writeAsBytesSync(imageFile!);
                XFile file = XFile(image.path);
                Share.shareXFiles([file]).then((value) => image.delete());
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: Center(
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                  color: Colors.amber,
                  width: double.infinity,
                  height: 220,
                  child: Stack(children: [
                    Center(child: Image.asset('assets/images/card.jpg')),
                    Positioned(
                        top: 60,
                        left: 155,
                        child: studentname.text.xs.bold.make()),
                    Positioned(
                        top: 87,
                        left: 155,
                        child: 'ID : ${box.read(Keys.sid).toString()}'
                            .text
                            .xs
                            .bold
                            .make()),
                    Positioned(
                        top: 158,
                        left: 105,
                        child: pathshala.text.scale(0.85).bold.make()),
                    Positioned(
                        top: 182, left: 105, child: mobile.text.xs.bold.make()),
                    Positioned(
                        top: 130,
                        left: 227,
                        child: QrImageView(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.white,
                          dataModuleStyle:
                              QrDataModuleStyle(color: AppColors.primaryColor),
                          data: box.read(Keys.sid).toString(),
                          version: QrVersions.auto,
                          size: 60.0,
                        )),
                  ])),
            ),
          ),
        ),
      ).onDoubleTap(() {
        _resetZoom();
      }),
    );
  }
}
