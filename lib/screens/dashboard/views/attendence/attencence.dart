import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              "Attendance Overview".text.lg.make(),
              const Spacer(),
              ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  Get.bottomSheet(
                    BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          height: 400,
                          child: ListView(
                            children: ["2024", "2025"].map((e) {
                              return ListTile(
                                title: Text(e),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                label: MyDate.currYear().text.white.make().marginOnly(left: 10),
              ),
            ],
          ),
          20.vs(),
          Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.dialog(const Material(
                              color: Colors.transparent,
                              child: Center(
                                child: SizedBox(
                                    height: 300, child: CalendarWidget()),
                              )).onTap(() => Get.back()));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Colors.grey.shade200,
                        title: MyDate.currMonth().text.bold.make(),
                        trailing: HStack([
                          "20/24 Days".text.make(),
                          10.hs(),
                          const Icon(Icons.calendar_month)
                        ]),
                        dense: true,
                      ),
                    );
                  })),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            dense: true,
            tileColor: AppColors.primaryColor,
            leading: const Icon(
              FontAwesomeIcons.calendarDays,
              color: Colors.white,
            ),
            title: "TOTAL ATTENDENCE".text.white.bold.make(),
            trailing: "200 DAYS".text.white.bold.lg.make(),
          ),
          20.vs()
        ],
      ).px(15),
    );
  }
}
