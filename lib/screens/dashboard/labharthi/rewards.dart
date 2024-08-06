import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/models/labharthi_modal.dart';
import 'package:maru_naam_che_pathshala_2/screens/zoomable_image/zoomable_image.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  List<RewardsModel> rewardList = [];
  int currentPage = 1;
  late int totalPages;
  bool load = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: "Rewards".text.white.make(),
        elevation: 0,
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 250,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 20),
          itemCount: rewardList.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () => Get.to(() => ZoomableImage(img: rewardList[i].img!)),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: rewardList[i].img!,
                        height: 125,
                        fit: BoxFit.fill,
                      ),
                    ),
                    4.vs(),
                    rewardList[i]
                        .reward
                        .toString()
                        .text
                        .bold
                        .white
                        .center
                        .make(),
                    4.vs(),
                    "OR\nAMOUNT ₹ : ${rewardList[i].amount}"
                        .text
                        .bold
                        .white
                        .center
                        .make(),
                    4.vs(),
                    "POINTS : ${rewardList[i].points}"
                        .text
                        .bold
                        .white
                        .center
                        .make(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  getData() async {
    final data = await ApiService.getData(endPoint: EndPoints.rewards);
    final result = rewardsModelFromJson(data);
    rewardList = result;
    load = true;
    setState(() {});
  }
}
