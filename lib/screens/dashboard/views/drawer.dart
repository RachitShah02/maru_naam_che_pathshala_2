import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/dashboard/views/home/idcard.dart';
import 'package:maru_naam_che_pathshala_2/screens/ledgerboard/ledger_board.dart';
import 'package:maru_naam_che_pathshala_2/screens/login/login.dart';
import 'package:maru_naam_che_pathshala_2/screens/pachkhan/pachkhan_screen.dart';
import 'package:maru_naam_che_pathshala_2/screens/parents_points/points_by_parents.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: false,
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 190,
                  color: AppColors.primaryColor,
                  child: VStack(
                    [
                      Image.asset(
                        logo,
                        width: 100,
                      ),
                      5.vs(),
                      "મારૂ નામ છે પાઠશાળા".text.xl.bold.white.make(),
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                    alignment: MainAxisAlignment.center,
                  ),
                ),
                20.vs(),
                ListTile(
                  onTap: () => Get.to(() => const IdcardScreen()),
                  leading: const Icon(
                    FontAwesomeIcons.idCard,
                    size: 22,
                  ),
                  title: "ID Card".text.make(),
                ),
                ListTile(
                  onTap: () => Get.to(() => const PointsByParentsScreen()),
                  leading: const Icon(
                    FontAwesomeIcons.listOl,
                    size: 22,
                  ),
                  title: "Points By Parents".text.make(),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const LedgerBoardScreen());
                  },
                  leading: const Icon(
                    FontAwesomeIcons.chartColumn,
                    size: 22,
                  ),
                  title: "Leaderboard".text.make(),
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.calendarDays,
                    size: 22,
                  ),
                  title: "Events".text.make(),
                ),
                ListTile(
                  onTap: () => Get.to(() => const PachkhanScreen()),
                  leading: const Icon(
                    FontAwesomeIcons.rectangleList,
                    size: 22,
                  ),
                  title: "Pachkhan".text.make(),
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.userGroup,
                    size: 22,
                  ),
                  title: "Labharthi".text.make(),
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.gifts,
                    size: 22,
                  ),
                  title: "Rewards".text.make(),
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.whatsapp,
                  ),
                  title: "Help".text.make(),
                ),
                ListTile(
                  onTap: () {
                    box.write(Keys.sid, '');
                    box.write(Keys.studentList, '');
                    Get.offAll(() => const LoginScreen());
                  },
                  leading: const Icon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    size: 22,
                  ),
                  title: "Logout".text.make(),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Privacy Policy".text.scale(0.85).make().px(5),
              "|".text.make(),
              "Terms & Conditions".text.scale(0.85).make().px(5),
            ],
          ).px(5),
          5.vs(),
          "Made By BIZYLOOK".text.make().py(3).onTap(() {
            launchurl(
                'https://wa.me/919327515849?text=hello from pathshala app');
          }),
          5.vs(),
        ],
      ),
    );
  }
}
