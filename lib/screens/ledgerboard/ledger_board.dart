import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/models/ledger_model.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class LedgerBoardScreen extends StatefulWidget {
  const LedgerBoardScreen({super.key});

  @override
  State<LedgerBoardScreen> createState() => _LedgerBoardScreenState();
}

class _LedgerBoardScreenState extends State<LedgerBoardScreen> {
  List<AllTop> allTop = [];
  List<AllTop> myPaths = [];
  List<String> img = [
    'assets/images/medal3.png',
    'assets/images/medal2.png',
    'assets/images/medal1.png'
  ];
  bool isload = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Ledgerboard".text.make(),
      ),
      body: (isload)
          ? Column(
              children: [
                10.vs(),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          [for (int i = 0; i < allTop.length; i++) i].map((i) {
                        Color bgcolor = Colors.yellow.shade100;
                        if (i == 1) {
                          bgcolor = Colors.grey.shade100;
                        } else if (i == 2) {
                          bgcolor = Colors.orange.shade100;
                        }
                        return Container(
                          decoration: BoxDecoration(
                              color: bgcolor,
                              borderRadius: BorderRadius.circular(10)),
                          width: (Get.width / 3) - 10,
                          child: Column(
                            children: [
                              5.vs(),
                              Image.asset(
                                img[i],
                                width: (Get.width / 3) - 30,
                              ),
                              10.vs(),
                              allTop[i].totalPoints!.text.bold.make(),
                              5.vs(),
                              allTop[i].pathshala!.text.center.xs.bold.make(),
                              5.vs(),
                              allTop[i].name!.text.center.xs.bold.make().px(4),
                            ],
                          ),
                        );
                      }).toList()),
                ).px(5),
                10.vs(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: "PATHSHALA TOP LIST".text.make(),
                ).px(10),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: myPaths.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            dense: true,
                            tileColor: Colors.grey.shade100,
                            leading: (i + 1).text.bold.make(),
                            title: myPaths[i]
                                .name!
                                .text
                                .sm
                                .bold
                                .maxLines(2)
                                .make(),
                            trailing: HStack(
                              [
                                const Icon(
                                  FontAwesomeIcons.medal,
                                  size: 15,
                                ),
                                5.hs(),
                                myPaths[i].totalPoints!.text.bold.make()
                              ],
                            ),
                          ).marginOnly(bottom: 10);
                        }))
              ],
            )
          : progressInd(),
    );
  }

  getData() async {
    final data = await ApiService.getData(endPoint: EndPoints.ledgerboard);
    final result = ledgerModelFromJson(data);
    allTop = result.allTop!;
    myPaths = result.myPath!;
    isload = true;
    setState(() {});
  }
}
