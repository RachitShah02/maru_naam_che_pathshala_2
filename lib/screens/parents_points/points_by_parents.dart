import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/models/parents_points_model.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class PointsByParentsScreen extends StatefulWidget {
  const PointsByParentsScreen({super.key});

  @override
  State<PointsByParentsScreen> createState() => _PointsByParentsScreenState();
}

class _PointsByParentsScreenState extends State<PointsByParentsScreen> {
  String selecteDate = '';
  List<ParentsPointsModel> pointList = [];
  List<bool> _isChecked = [];
  bool isPosted = false;
  List<String> dates = [];
  bool isLoad = false;
  @override
  void initState() {
    super.initState();
    getDates();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selecteDate == '' ? true : false,
      onPopInvoked: (_) {
        if (selecteDate != '') {
          setState(() {
            _isChecked = [];
            pointList = [];
            selecteDate = '';
          });
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                if (selecteDate != '') {
                  setState(() {
                    _isChecked = [];
                    pointList = [];
                    selecteDate = '';
                  });
                } else {
                  Get.back();
                }
              },
            ),
            title: (selecteDate == '' ? 'SELECT DATE' : '').text.make(),
            actions: [
              HStack(
                [
                  const Icon(Icons.calendar_month),
                  if (selecteDate.isNotBlank) 5.hs(),
                  selecteDate.text.white.bold.make()
                ],
              )
                  .box
                  .border(color: Colors.white)
                  .p4
                  .makeCentered()
                  .marginOnly(right: 10)
            ],
          ),
          bottomNavigationBar: (selecteDate != '')
              ? Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  color: AppColors.primaryColor,
                  child: "ADD POINTS".text.lg.white.bold.make(),
                ).onTap(() {
                  if (!isPosted) postData();
                })
              : null,
          body: (selecteDate == '' && dates.isNotEmpty)
              ? ListView(
                  padding: const EdgeInsets.all(10),
                  children: dates.generate(
                    (e) {
                      return ListTile(
                        onTap: () {
                          selecteDate = dates[e];
                          pointList = [];
                          _isChecked = [];
                          setState(() {});
                          getData(dates[e]);
                        },
                        tileColor: AppColors.primaryColor,
                        leading: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                        ),
                        title: dates[e].text.white.make(),
                        trailing: const Icon(Icons.chevron_right,
                            color: Colors.white),
                      ).card.elevation(2).make().pOnly(
                            top: e == 0 ? 10 : 5,
                            bottom: 5,
                          );
                    },
                  ))
              : dates.isEmpty
                  ? progressInd()
                  : (pointList.isNotEmpty && !isPosted)
                      ? ListView.builder(
                          itemCount: pointList.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              leading: Checkbox(
                                value: _isChecked[i],
                                onChanged: (v) {
                                  setState(() {
                                    _isChecked[i] =
                                        v ?? false; // Update the checkbox state
                                  });
                                },
                              ),
                              title: pointList[i].details!.text.make(),
                            );
                          })
                      : (pointList.isEmpty && !isLoad)
                          ? progressInd()
                          : Center(
                              child: "ALL POINTS GIVEN".text.make(),
                            )),
    );
  }

  getDates() async {
    final data = await ApiService.getData(endPoint: EndPoints.pointsDates);
    Map<String, dynamic> dateMap = jsonDecode(data);
    dates = [dateMap['day1'], dateMap['day2'], dateMap['day3']];
    setState(() {});
  }

  getData(String date) async {
    String q = date.isNotBlank ? '&date=$selecteDate' : '';
    final data = await ApiService.getData(
        endPoint: EndPoints.parentsPointsList, query: q);
    final result = parentsPointsModelFromJson(data);
    pointList = result;
    _isChecked = List<bool>.filled(pointList.length, false);
    isLoad = true;
    setState(() {});
  }

  postData() async {
    if (isPosted) return;
    setState(() {
      isPosted = true;
    });

    List<String> checkedIds = [];
    for (int i = 0; i < pointList.length; i++) {
      if (_isChecked[i]) {
        checkedIds.add(pointList[i].id!);
      }
    }
    String idList = jsonEncode(checkedIds);
    final postId = <String, String>{'checkedIds': idList, 'date': selecteDate};
    final data =
        await ApiService.postData(endPoint: EndPoints.addPoints, data: postId);
    final result = addPointsResponseModelFromJson(data);
    if (result.add!) {
      customSnackBar(
          title: "Success",
          message: "Points Added",
          type: SnackBarType.success);
    } else {
      customSnackBar(
          title: "Failed", message: "Try Again!", type: SnackBarType.danger);
    }
    pointList = [];
    checkedIds = [];
    getData(selecteDate);
    isPosted = false;
    setState(() {});
  }
}
