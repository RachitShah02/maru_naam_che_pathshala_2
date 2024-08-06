import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/screens.dart';
import 'package:maru_naam_che_pathshala_2/screens/webviews/webview.dart';
import 'package:maru_naam_che_pathshala_2/screens/zoomable_image/zoomable_image.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currSlide = 0;
  List<Attendence>? attendence;
  List<HomeSlider>? homeSlider;
  String currentPoints = "0";
  String totalPoints = "0";
  Sutra? sutra;
  Pathshala? pathshala;
  TotalAttendence? totalAttendence;
  bool isLoad = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: (isLoad)
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    15.vs(),
                    slider(),
                    15.vs(),
                    totalPointsCard().px(15),
                    15.vs(),
                    currentMonthPoints().px(10),
                    15.vs(),
                    attendenceCard().px(10),
                    15.vs(),
                    detailsCard().px(10),
                    15.vs(),
                    if (sutra != null) sutraCard().px(10),
                    30.vs()
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              )),
        floatingActionButton: heroRoute(
            context: context,
            heroTag: "card",
            icon: FontAwesomeIcons.qrcode,
            barrierColor: Colors.transparent,
            pushTo: QrCodeScreen(
              qrData: box.read(Keys.sid),
            )));
  }

  ListTile totalPointsCard() {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      dense: true,
      tileColor: AppColors.primaryColor,
      leading: const Icon(
        FontAwesomeIcons.trophy,
        color: Colors.white,
      ),
      title: "TOTAL POINTS".text.white.bold.make(),
      trailing: HStack([
        const Icon(
          FontAwesomeIcons.medal,
          size: 20,
          color: Colors.white,
        ),
        10.hs(),
        totalPoints.text.white.bold.lg.make(),
      ]),
    );
  }

  Card currentMonthPoints() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () {
          Get.to(() => const PointScreen(
                showAppBar: true,
              ));
        },
        title: MyDate.currMonth().text.bold.make(),
        subtitle: "Current Month".text.make(),
        trailing: HStack([
          const Icon(
            FontAwesomeIcons.medal,
            size: 15,
            color: Colors.grey,
          ),
          10.hs(),
          "$currentPoints Points".text.make(),
          10.hs(),
          const Icon(Icons.chevron_right_rounded)
        ]),
      ),
    );
  }

  Card sutraCard() {
    String sutraName = '';
    String gatha = '';
    String sutraDate = '';
    if (sutra != null) {
      sutraName = sutra!.sutra!;
      gatha = sutra!.gatha!.toString();
      sutraDate = sutra!.date!;
    }

    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Current Learning".text.xl.thin.make(),
            10.vs(),
            "Sutra : $sutraName".text.make().py(5),
            "Gatha : $gatha".text.make().py(5),
            "Complete Date : $sutraDate".text.make().py(5)
          ],
        ),
      ),
    );
  }

  Card attendenceCard() {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: VStack(
          [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Attendence".text.thin.make(),
                    "${MyDate.currMonth()} ${MyDate.currYear()}"
                        .text
                        .center
                        .xl
                        .bold
                        .make(),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    "Total Attendence".text.thin.make(),
                    "${totalAttendence!.attendance} / ${totalAttendence!.days} days"
                        .text
                        .bold
                        .make()
                  ],
                )
              ],
            ),
            CalendarWidget(
              attendenceList: attendence!,
            )
          ],
          crossAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  Card detailsCard() {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: Get.width,
        child: VStack([
          "Pathshala Details".text.lg.make(),
          const Divider(),
          10.vs(),
          richText(context,
              firstText: "Pathshala : ",
              secondText: pathshala!.pathshala!,
              sstyle: MyTextStyle.bold()),
          5.vs(),
          richText(context,
              firstText: "Time : ",
              secondText: pathshala!.time!,
              sstyle: MyTextStyle.bold()),
          5.vs(),
          richText(context,
              firstText: "Guruji : ",
              secondText: pathshala!.panditji!,
              sstyle: MyTextStyle.bold()),
          5.vs(),
          richText(context,
              firstText: "Guruji No: ",
              secondText: pathshala!.mobile!,
              sstyle: MyTextStyle.bold()),
        ]),
      ),
    );
  }

  Column slider() {
    return Column(
      children: [
        SizedBox(
          width: Get.width,
          height: 180,
          child: PageView.builder(
              onPageChanged: (v) {
                setState(() {
                  _currSlide = v;
                });
              },
              itemCount: homeSlider!.length,
              itemBuilder: (context, i) {
                return CachedNetworkImage(
                  imageUrl: homeSlider![i].img!,
                  fit: BoxFit.fill,
                ).card.make().px(10).onTap(() async {
                  String target = homeSlider![i].target!;
                  String type = homeSlider![i].type!;
                  if (type == 'banner') {
                    Get.to(() => ZoomableImage(img: target));
                  } else if (type == 'inappurl') {
                    Get.to(() => MyWebView(url: target));
                  } else if (type == 'outappurl') {
                    launchurl(target);
                  }
                });
              }),
        ).marginOnly(bottom: 10),
        if (homeSlider!.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(homeSlider!.length, (index) {
              return Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_currSlide == index)
                        ? AppColors.primaryColor
                        : Colors.blueGrey),
              ).marginSymmetric(horizontal: 3);
            }),
          ),
      ],
    );
  }

  getData() async {
    final data = await ApiService.getData(endPoint: EndPoints.homescreen);
    log(data);
    final result = homeScreenModelFromJson(data);
    attendence = result.attendence;
    homeSlider = result.slider;
    currentPoints = result.currentPoints!;
    totalPoints = result.totalPoints!;
    sutra = result.sutra;
    pathshala = result.pathshala;
    box.write(Keys.pathshalaDetails, pathshala!);
    totalAttendence = result.totalAttendence;
    isLoad = true;
    setState(() {});
  }
}
