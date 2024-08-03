// To parse this JSON data, do
//
//     final pointsListModel = pointsListModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final pointsListModel = pointsListModelFromJson(jsonString);

import 'dart:convert';

PointsListModel pointsListModelFromJson(String str) =>
    PointsListModel.fromJson(json.decode(str));

String pointsListModelToJson(PointsListModel data) =>
    json.encode(data.toJson());

class PointsListModel {
  final List<PointList>? pointList;
  final String? total;
  final List<String>? yearlist;

  PointsListModel({
    this.pointList,
    this.total,
    this.yearlist,
  });

  factory PointsListModel.fromJson(Map<String, dynamic> json) =>
      PointsListModel(
        pointList: json["point_list"] == null
            ? []
            : List<PointList>.from(
                json["point_list"]!.map((x) => PointList.fromJson(x))),
        total: json["total"],
        yearlist: json["yearlist"] == null
            ? []
            : List<String>.from(json["yearlist"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "point_list": pointList == null
            ? []
            : List<dynamic>.from(pointList!.map((x) => x.toJson())),
        "total": total,
      };
}

class PointList {
  final String? month;
  final int? monthNum;
  final String? totalPoints;
  final String? year;

  PointList({
    this.month,
    this.monthNum,
    this.totalPoints,
    this.year,
  });

  factory PointList.fromJson(Map<String, dynamic> json) => PointList(
        month: json["month"],
        monthNum: json["month_num"],
        totalPoints: json["totalPoints"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "month_num": monthNum,
        "totalPoints": totalPoints,
        "year": year,
      };
}

// To parse this JSON data, do
//
//     final pointsCardModel = pointsCardModelFromJson(jsonString);

List<PointsCardModel> pointsCardModelFromJson(String str) =>
    List<PointsCardModel>.from(
        json.decode(str).map((x) => PointsCardModel.fromJson(x)));

String pointsCardModelToJson(List<PointsCardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PointsCardModel {
  final int? id;
  final String? details;
  final int? points;
  final String? type;
  final String? pid;
  final String? date;
  final String? time;
  final int? day;

  PointsCardModel(
      {this.id,
      this.details,
      this.points,
      this.type,
      this.pid,
      this.date,
      this.time,
      this.day});

  factory PointsCardModel.fromJson(Map<String, dynamic> json) =>
      PointsCardModel(
        id: json["id"],
        details: json["details"],
        points: json["points"],
        type: json["type"],
        pid: json["pid"],
        date: json["date"],
        time: json["time"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
        "points": points,
        "type": type,
        "pid": pid,
        "date": date,
        "time": time,
        "day": day
      };
}
