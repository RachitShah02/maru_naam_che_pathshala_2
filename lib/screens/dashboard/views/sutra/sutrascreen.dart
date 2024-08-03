import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class Sutrascreen extends StatefulWidget {
  const Sutrascreen({super.key});

  @override
  State<Sutrascreen> createState() => _SutrascreenState();
}

class _SutrascreenState extends State<Sutrascreen> {
  List<SutraListModel> sutra = [];
  bool isLoad = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Learning Overview".text.lg.make(),
          10.vs(),
          Expanded(
              child: (sutra.isNotEmpty)
                  ? ListView.builder(
                      itemCount: sutra.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.dialog(
                                Center(
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      width: Get.width * 0.8,
                                      height: 230,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              "DETAILS".text.bold.make(),
                                              const Spacer(),
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () => Get.back(),
                                                icon: const Icon(
                                                  FontAwesomeIcons.xmark,
                                                  size: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                          5.vs(),
                                          const Divider(
                                            height: 3,
                                          ),
                                          5.vs(),
                                          richText(context,
                                                  firstText: "Sutra : ",
                                                  secondText: sutra[i].sutra!,
                                                  sstyle: MyTextStyle.bold())
                                              .py(5)
                                              .flexible(),
                                          richText(context,
                                                  firstText: "Gatha : ",
                                                  secondText: sutra[i].gatha!,
                                                  sstyle: MyTextStyle.bold())
                                              .py(5),
                                          richText(context,
                                                  firstText: "Complete Date : ",
                                                  secondText: sutra[i].date!,
                                                  sstyle: MyTextStyle.bold())
                                              .py(5),
                                          richText(context,
                                                  firstText: "Points : ",
                                                  secondText: sutra[i].points!,
                                                  sstyle: MyTextStyle.bold())
                                              .py(5)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: Colors.grey.shade200,
                            title: sutra[i].sutra!.text.bold.make(),
                            trailing: HStack([
                              "${sutra[i].points} Points".text.make(),
                              10.hs(),
                              const Icon(Icons.list_alt)
                            ]),
                            dense: true,
                          ),
                        );
                      })
                  : (!isLoad)
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
                                  Icons.book,
                                  size: 90,
                                  color: AppColors.primaryColor,
                                ),
                                10.vs(),
                                "Sutra Not Found".text.xl.bold.make()
                              ],
                            ),
                          ),
                        ))
        ],
      ).px(15),
    );
  }

  getData() async {
    final data = await ApiService.getData(endPoint: EndPoints.sutraList);
    final result = sutraListModelFromJson(data);
    sutra = result;
    isLoad = true;
    setState(() {});
  }
}
