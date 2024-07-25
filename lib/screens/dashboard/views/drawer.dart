import 'package:flutter/material.dart';
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
                  height: 210,
                  color: AppColors.primaryColor,
                  child: VStack(
                    [
                      Image.asset(
                        logo,
                        width: 120,
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
                  leading: const Icon(
                    FontAwesomeIcons.chartBar,
                    size: 22,
                  ),
                  title: "Leaderboard".text.make(),
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
                    FontAwesomeIcons.listOl,
                    size: 22,
                  ),
                  title: "Points Card".text.make(),
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.calendarDays,
                    size: 22,
                  ),
                  title: "Events".text.make(),
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
                    FontAwesomeIcons.user,
                    size: 22,
                  ),
                  title: "My Profile".text.make(),
                ),
                ListTile(
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
              "Privacy Policy".text.sm.make().p(10),
              "|".text.make().p(10),
              "Terms & Conditions".text.sm.make().p(10),
            ],
          ),
        ],
      ),
    );
  }
}
