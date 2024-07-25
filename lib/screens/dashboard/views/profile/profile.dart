import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          dense: true,
          leading: const Icon(
            FontAwesomeIcons.calendarDays,
          ),
          title: "TOTAL ATTENDENCE".text.bold.make(),
          trailing: "200 DAYS".text.bold.lg.make(),
        ).px(10),
        ListTile(
          dense: true,
          leading: const Icon(
            FontAwesomeIcons.star,
          ),
          title: "TOTAL POINTS".text.bold.make(),
          trailing: "2000 POINTS".text.bold.lg.make(),
        ).px(10),
        personalDetailsCard().px(10),
        15.vs(),
        detailsCard().px(10),
        15.vs(),
        sutraCard().px(10),
        15.vs(),
      ],
    ));
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
              secondText: "Veeha Rachit Shah",
              sstyle: MyTextStyle.combine(MyTextStyle.bold(), fontSize: 16)),
          5.vs(),
          richText(context,
              firstText: "Parent Name : ",
              secondText: "Rachit P Shah",
              sstyle: MyTextStyle.combine(MyTextStyle.bold(), fontSize: 16)),
          5.vs(),
          richText(context,
              firstText: "Parent No : ",
              secondText: "9016226764",
              sstyle: MyTextStyle.combine(MyTextStyle.bold(), fontSize: 16)),
          5.vs(),
          richText(context,
              firstText: "Address : ",
              secondText: "H-404, Vasu Darshan Residency, Pal, Surat",
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
            5.vs(),
            const Divider(
              endIndent: 20,
              height: 3,
            ),
            10.vs(),
            "Pathshala : ".text.make(),
            5.vs(),
            "Guruji : ".text.make(),
            5.vs(),
            "Guruji No : ".text.make()
          ])),
    );
  }

  Card sutraCard() {
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
            "Sutra : Navkar".text.make().py(5),
            "Gatha : 3/9".text.make().py(5),
            "Starting Date : 24-07-2024".text.make().py(5)
          ],
        ),
      ),
    );
  }
}
