import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({super.key, this.showAppBar = false});
  final bool showAppBar;

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  String year = MyDate.currYear();
  List<PointList> list = [];
  List<PointsCardModel> pointsCard = [];
  String total = '0';
  List<String> yearList = [];
  bool isLoad = false;
  bool isCardLoad = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: "Points".text.make(),
            )
          : null,
      body: Column(
        children: [
          if (widget.showAppBar) 20.vs(),
          Row(
            children: [
              "Points Overview".text.lg.make(),
              const Spacer(),
              ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  Get.bottomSheet(
                    BottomSheet(
                      onClosing: () {
                        setState(() {
                          pointsCard.clear();
                        });
                      },
                      builder: (context) {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          height: 400,
                          child: ListView(
                            children: yearList.map((e) {
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    year = e;
                                  });
                                  getData(qyear: e);
                                  Get.back();
                                },
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
                label: year.text.white.make().marginOnly(left: 10),
              ),
            ],
          ),
          20.vs(),
          Expanded(
            child: (list.isNotEmpty)
                ? ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          onTap: () async {
                            await getPointCard(list[i].monthNum.toString());
                            Get.bottomSheet(
                              isScrollControlled: true,
                              isDismissible: true,
                              DraggableScrollableSheet(
                                expand: false,
                                initialChildSize: 0.5,
                                maxChildSize: 0.9,
                                builder: (context, scrollController) {
                                  return Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 8),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: ListView.builder(
                                          controller: scrollController,
                                          itemCount: (pointsCard.isNotEmpty)
                                              ? pointsCard.length
                                              : 1,
                                          itemBuilder: (context, index) {
                                            if (pointsCard.isEmpty) {
                                              if (!isCardLoad) {
                                                return progressInd();
                                              } else {
                                                return const Center(
                                                  child:
                                                      Text("NO POINTS FOUND"),
                                                ).marginOnly(top: 30);
                                              }
                                            } else {
                                              return Column(
                                                children: [
                                                  if (index == 0) 15.vs(),
                                                  ListTile(
                                                    dense: true,
                                                    leading: Text(
                                                      pointsCard[index].date!,
                                                    ),
                                                    title: Text(
                                                      pointsCard[index]
                                                          .details!,
                                                    ),
                                                    trailing: Text(
                                                      "${pointsCard[index].points!} Points",
                                                    ),
                                                  ),
                                                  const Divider(),
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 0,
                                        right: 0,
                                        child: Center(
                                          child: Container(
                                            height: 6,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.grey.shade200,
                          title: list[i].month!.text.bold.make(),
                          trailing: HStack([
                            "${list[i].totalPoints} Points".text.make(),
                            10.hs(),
                            const Icon(Icons.list_alt)
                          ]),
                          dense: true,
                        ),
                      );
                    },
                  )
                : !isLoad
                    ? progressInd()
                    : Center(
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.medal,
                                size: 90,
                                color: AppColors.primaryColor,
                              ),
                              10.vs(),
                              "No Points Found".text.xl.bold.make(),
                            ],
                          ),
                        ),
                      ),
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
              total.text.white.bold.lg.make(),
            ]),
          ),
          20.vs(),
        ],
      ).px(15),
    );
  }

  getData({String? qyear}) async {
    String query = '';
    if (qyear != null) {
      log(qyear);
      query = '&year=$qyear';
      year = qyear;
    }
    final data =
        await ApiService.getData(endPoint: EndPoints.pointsList, query: query);
    final result = pointsListModelFromJson(data);
    setState(() {
      list = result.pointList!;
      total = result.total!;
      yearList = result.yearlist!;
      isLoad = true;
    });
  }

  getPointCard(String month) async {
    setState(() {
      isCardLoad = false;
    });
    final data = await ApiService.getData(
        endPoint: EndPoints.pointsCard, query: "&month=$month");
    final result = pointsCardModelFromJson(data);
    log(data);
    setState(() {
      pointsCard = result;
      isCardLoad = true;
    });
  }
}
