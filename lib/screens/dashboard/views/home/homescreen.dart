import 'package:flutter/material.dart';

import 'package:maru_naam_che_pathshala_2/screens/screens.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currSlide = 0;
  String sutra = 'Annath';
  String gatha = '1/4';
  String sutraStartDate = '10-07-2024';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                slider(),
                15.vs(),
                detailsCard().px(10),
                15.vs(),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => const PointScreen(
                            showAppBar: true,
                          ));
                    },
                    title: MyDate.currMonth().text.bold.make(),
                    subtitle: "Current Month".text.make(),
                    trailing: HStack([
                      "200 Points".text.make(),
                      10.hs(),
                      const Icon(Icons.chevron_right_rounded)
                    ]),
                    dense: true,
                  ),
                ).px(10),
                15.vs(),
                attendenceCard().px(10),
                15.vs(),
                sutraCard().px(10),
                30.vs()
              ],
            ),
          ),
        ),
        floatingActionButton: heroRoute(
            context: context,
            heroTag: "card",
            icon: FontAwesomeIcons.qrcode,
            barrierColor: Colors.transparent,
            pushTo: const IdCardScreen(
              qrData: 'MNP0001',
            )));
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
            "Current Learning".text.xl.thin.make(),
            10.vs(),
            "Sutra : $sutra".text.make().py(5),
            "Gatha : $gatha".text.make().py(5),
            "Starting Date : $sutraStartDate".text.make().py(5)
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
                  children: [
                    "Total Attendence".text.thin.make(),
                    "20 / 25 days".text.bold.make()
                  ],
                )
              ],
            ),
            const CalendarWidget()
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
        child: HStack(
          [
            VStack([
              "Pathshala Details".text.lg.make(),
              10.vs(),
              "Pathshala : ".text.make(),
              5.vs(),
              "Guruji : ".text.make(),
              5.vs(),
              "Guruji No : ".text.make()
            ]).flexible(),
            20.hs(),
            VStack(
              [
                Icon(
                  FontAwesomeIcons.trophy,
                  color: AppColors.primaryColor,
                  size: 50,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: CustomPaint(
                        size: const Size(80, 22),
                        painter: RibbonPainter(),
                      ),
                    ),
                    Center(child: "2000".text.bold.white.make()),
                  ],
                ),
                10.vs(),
                "Total Points".text.lg.make(),
              ],
              crossAlignment: CrossAxisAlignment.center,
            ).flexible()
          ],
          crossAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  Column slider() {
    return Column(
      children: [
        SizedBox(
          width: Get.width,
          height: 100,
          child: PageView.builder(
              onPageChanged: (v) {
                setState(() {
                  _currSlide = v;
                });
              },
              itemCount: 5,
              itemBuilder: (context, i) {
                return const Placeholder().px(20);
              }),
        ).marginOnly(bottom: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
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
}

class RibbonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width * -0.1, 0)
      ..lineTo(size.width * 1.1, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width * 1.1, size.height)
      ..lineTo(size.width * -0.1, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
