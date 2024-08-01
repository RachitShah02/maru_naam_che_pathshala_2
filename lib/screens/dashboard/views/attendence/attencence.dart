import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  bool isLoad = false;
  List<AttListElement> list = [];
  int total = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

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
              child: (isLoad)
                  ? ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.dialog(const Material(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: SizedBox(
                                        height: 300,
                                        child: CalendarWidget(
                                          attendenceList: [],
                                        )),
                                  )).onTap(() => Get.back()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: Colors.grey.shade200,
                            title: list[i].month!.text.bold.make(),
                            trailing: HStack([
                              "${list[i].attendance} / ${list[i].totalDays} Days"
                                  .text
                                  .make(),
                              10.hs(),
                              const Icon(Icons.calendar_month)
                            ]),
                            dense: true,
                          ),
                        );
                      })
                  : progressInd()),
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
            trailing: "$total DAYS".text.white.bold.lg.make(),
          ),
          20.vs()
        ],
      ).px(15),
    );
  }

  getData() async {
    final data = await ApiService.getData(endPoint: EndPoints.attendenceList);
    final result = attendenceListModelFromJson(data);
    list = result.list!;
    total = result.total!;
    isLoad = true;
    setState(() {});
  }
}
