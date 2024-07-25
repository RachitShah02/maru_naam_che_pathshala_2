import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class Sutrascreen extends StatefulWidget {
  const Sutrascreen({super.key});

  @override
  State<Sutrascreen> createState() => _SutrascreenState();
}

class _SutrascreenState extends State<Sutrascreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Learning Overview".text.lg.make(),
          10.vs(),
          Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.dialog(
                            Center(
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  width: Get.width * 0.8,
                                  height: 250,
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
                                      "Sutra : Navkar"
                                          .text
                                          .maxLines(2)
                                          .make()
                                          .py(5)
                                          .flexible(),
                                      "Gatha : 9".text.make().py(5),
                                      "Starting Date : 24 July 2024"
                                          .text
                                          .make()
                                          .py(5),
                                      "Complete Date : 25 July 2024"
                                          .text
                                          .make()
                                          .py(5),
                                      "Total Points : 25".text.make().py(5)
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
                        title: "Navkar".text.bold.make(),
                        trailing: HStack([
                          "200 Points".text.make(),
                          10.hs(),
                          const Icon(Icons.list_alt)
                        ]),
                        dense: true,
                      ),
                    );
                  }))
        ],
      ).px(15),
    );
  }
}
