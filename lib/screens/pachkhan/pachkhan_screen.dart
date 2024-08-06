import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/pachkhan/pachkhan_details.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class PachkhanScreen extends StatefulWidget {
  const PachkhanScreen({super.key});

  @override
  State<PachkhanScreen> createState() => _PachkhanScreenState();
}

class _PachkhanScreenState extends State<PachkhanScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: PachkhanString.divasNaPachkhan.text.bold.make(),
      ),
      body: ListView(
        children: [
          tile(PachkhanString.navkarshititle, 0),
          tile(PachkhanString.porishititle, 1),
          tile(PachkhanString.parimudhtitle, 2),
          tile(PachkhanString.akasanutitle, 3),
          tile(PachkhanString.ayambiltitle, 4),
          tile(PachkhanString.tiviharupvastitle, 5),
          tile(PachkhanString.choviharupvastitle, 6),
          ListTile(
              title: PachkhanString.raatNaPachkhan.text.white.bold.make(),
              tileColor: AppColors.primaryColor),
          tile(PachkhanString.chovihartitle, 7),
          tile(PachkhanString.tivihartitle, 8),
          tile(PachkhanString.duvihartitle, 9),
          tile(PachkhanString.desavagasikatitle, 10),
          tile(PachkhanString.dharnatitle, 11),
        ],
      ),
    );
  }

  Widget tile(String title, int code) => ListTile(
        onTap: () {
          Get.to(() => PachkhanDetails(code: code, title: title));
        },
        tileColor: Colors.white,
        title: title.text.scale(1).make(),
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
      ).marginOnly(bottom: 2);
}
