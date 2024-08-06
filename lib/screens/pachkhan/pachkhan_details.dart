import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class PachkhanDetails extends StatefulWidget {
  final int code;
  final String title;
  const PachkhanDetails({super.key, required this.code, required this.title});

  @override
  State<PachkhanDetails> createState() => _PachkhanDetailsState();
}

class _PachkhanDetailsState extends State<PachkhanDetails> {
  final pachkhanEng = [
    PachkhanString.navkarsieng,
    PachkhanString.porishieng,
    PachkhanString.parimudheng,
    PachkhanString.ekasanuBiyasanueng,
    PachkhanString.ayambilNivieng,
    PachkhanString.tiviharupvaseng,
    PachkhanString.choviharupvaseng,
    PachkhanString.chauvihareng,
    PachkhanString.tivihareng,
    PachkhanString.duvihareng,
    PachkhanString.desavagasikaeng,
    PachkhanString.dharnaeng
  ];
  final pachkhanGuj = [
    PachkhanString.navkarsiguj,
    PachkhanString.porishiguj,
    PachkhanString.parimudhguj,
    PachkhanString.ekasanuBiyasanuguj,
    PachkhanString.ayambilNiviguj,
    PachkhanString.tiviharupvasguj,
    PachkhanString.choviharupvasguj,
    PachkhanString.chauviharguj,
    PachkhanString.tiviharguj,
    PachkhanString.duviharguj,
    PachkhanString.desavagasikaguj,
    PachkhanString.dharnaguj
  ];

  final audioPachkhan = [
    'navkarshi.mp3',
    'porshi_sadhporshi.mp3',
    'parimudh_avadh.mp3',
    'aekasanu_biyasanu.mp3',
    'amybil.mp3',
    'tivihar_upvas.mp3',
    'chovihar_upvas.mp3',
    'chovihar.mp3',
    'tivihar.mp3',
    'duvihar_pachkhan.mp3',
    'desavagasik_pachkhan.mp3',
    'dharna_abhigrha.mp3'
  ];

  int isPlay = 0;
  String play = "Play Pachkhan";
  IconData playIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isPlay == 1 ? false : true,
      onPopInvoked: (_) async {
        if (isPlay == 1) {
          await audioPlayer.stop();
          setState(() {
            isPlay = 0;
            play = 'Play Pachkhan';
            playIcon = Icons.play_arrow;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () async {
              if (isPlay == 1) {
                await audioPlayer.stop();
                setState(() {
                  isPlay = 0;
                  play = 'Play Pachkhan';
                  playIcon = Icons.play_arrow;
                });
              } else {
                Get.back();
              }
            },
          ),
          title:
              widget.title.replaceAll("\n", " ").text.maxLines(1).white.make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            ListTile(title: pachkhanGuj[widget.code].text.make()),
            10.vs(),
            Divider(color: AppColors.primaryColor),
            10.vs(),
            ListTile(title: pachkhanEng[widget.code].text.make()),
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () async {
              if (isPlay == 0) {
                await audioPlayer.setSourceUrl(
                    "https://hellothirpur.com/raw/${audioPachkhan[widget.code]}");
                await audioPlayer.resume();
                isPlay = 1;
                play = 'Stop Playing...';
                playIcon = Icons.stop;
                setState(() {});

                audioPlayer.onPlayerComplete.listen((event) {
                  setState(() {
                    isPlay = 0;
                    play = 'Play Pachkhan';
                    playIcon = Icons.play_arrow;
                  });
                });
              } else {
                await audioPlayer.stop();
                setState(() {
                  isPlay = 0;
                  play = 'Play Pachkhan';
                  playIcon = Icons.play_arrow;
                });
              }
            },
            child: Icon(
              playIcon,
              size: 35,
              color: Colors.white,
            )),
        bottomNavigationBar: Container(
          height: 50,
          color: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [play.text.white.bold.make()],
          ),
        ),
      ),
    );
  }
}
