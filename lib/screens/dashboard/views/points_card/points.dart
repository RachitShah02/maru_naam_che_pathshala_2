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
                                onTap: () {
                                  setState(() {
                                    year = e;
                                  });
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
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        onTap: () {
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
                                                topRight: Radius.circular(20))),
                                        child: ListView.builder(
                                          controller: scrollController,
                                          itemCount: 24,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              dense: true,
                                              leading:
                                                  "$index ${MyDate.currMonth()}"
                                                      .text
                                                      .make(),
                                              title: 'Attendence ${index + 1}'
                                                  .text
                                                  .sm
                                                  .make(),
                                              trailing: "10 Points".text.make(),
                                            );
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
                              ));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Colors.grey.shade200,
                        title: MyDate.currMonth().text.bold.make(),
                        trailing: HStack([
                          "200 Points".text.make(),
                          10.hs(),
                          const Icon(Icons.list_alt)
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
              FontAwesomeIcons.trophy,
              color: Colors.white,
            ),
            title: "TOTAL POINTS".text.white.bold.make(),
            trailing: "2000".text.white.bold.lg.make(),
          ),
          20.vs()
        ],
      ).px(15),
    );
  }
}
