import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/models/profile_model.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late StudentModel? student;
  late Pathshala? pathshala;
  late Sutra? sutra;
  int totalAttendence = 0;
  String totalPoints = "0";
  bool isload = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (isload)
            ? ListView(
                children: [
                  Card(
                    elevation: 2,
                    child: ListTile(
                      dense: true,
                      leading: const Icon(
                        FontAwesomeIcons.calendarDays,
                      ),
                      title: "TOTAL ATTENDENCE".text.bold.make(),
                      trailing:
                          "$totalAttendence DAYS".text.bold.red500.lg.make(),
                    ),
                  ).px(10),
                  15.vs(),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      dense: true,
                      leading: const Icon(
                        FontAwesomeIcons.star,
                      ),
                      title: "TOTAL POINTS".text.bold.make(),
                      trailing:
                          "$totalPoints POINTS".text.bold.red500.lg.make(),
                    ),
                  ).px(10),
                  15.vs(),
                  personalDetailsCard().px(10),
                  15.vs(),
                  detailsCard().px(10),
                  15.vs(),
                  sutraCard().px(10),
                  15.vs(),
                ],
              )
            : progressInd());
  }

  Card personalDetailsCard() {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: Get.width,
        child: VStack([
          "Personal Details".text.lg.make(),
          5.vs(),
          const Divider(
            endIndent: 20,
            height: 3,
          ),
          10.vs(),
          richText(context,
              firstText: "Name : ",
              secondText: student!.fullName!,
              sstyle: MyTextStyle.combine(
                MyTextStyle.bold(),
                fontSize: 14,
              )),
          5.vs(),
          richText(context,
              firstText: "Parent Name : ",
              secondText: student!.parentName!,
              sstyle: MyTextStyle.combine(MyTextStyle.bold(), fontSize: 14)),
          5.vs(),
          richText(context,
              firstText: "Parent No : ",
              secondText: student!.mo1!,
              sstyle: MyTextStyle.combine(MyTextStyle.bold(), fontSize: 14)),
          5.vs(),
          richText(context,
              firstText: "Address : ",
              secondText: student!.fullAddress!,
              sstyle: MyTextStyle.combine(MyTextStyle.bold(), fontSize: 14)),
        ]),
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
            "Current Learning".text.lg.thin.make(),
            5.vs(),
            const Divider(
              endIndent: 20,
              height: 3,
            ),
            10.vs(),
            "Sutra : $sutraName".text.make(),
            5.vs(),
            "Gatha : $gatha".text.make(),
            5.vs(),
            "Complete Date : $sutraDate".text.make()
          ],
        ),
      ),
    );
  }

  getData() async {
    final data = await ApiService.getData(endPoint: EndPoints.profile);
    final result = profileModelFromJson(data);
    student = result.student;
    pathshala = result.pathshala;
    sutra = result.sutra;
    totalPoints = result.totalPoints!;
    totalAttendence = result.totalAttendence!;
    isload = true;
    setState(() {});
  }
}
