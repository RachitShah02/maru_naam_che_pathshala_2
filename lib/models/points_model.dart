// To parse this JSON data, do
//
//     final pointsListModel = pointsListModelFromJson(jsonString);

import 'dart:convert';

List<PointsListModel> pointsListModelFromJson(String str) =>
    List<PointsListModel>.from(
        json.decode(str).map((x) => PointsListModel.fromJson(x)));

String pointsListModelToJson(List<PointsListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PointsListModel {
  final String? month;
  final String? totalPoints;
  final String? year;

  PointsListModel({
    this.month,
    this.totalPoints,
    this.year,
  });

  factory PointsListModel.fromJson(Map<String, dynamic> json) =>
      PointsListModel(
        month: json["month"],
        totalPoints: json["totalPoints"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
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

  PointsCardModel({
    this.id,
    this.details,
    this.points,
    this.type,
    this.pid,
    this.date,
    this.time,
  });

  factory PointsCardModel.fromJson(Map<String, dynamic> json) =>
      PointsCardModel(
        id: json["id"],
        details: json["details"],
        points: json["points"],
        type: json["type"],
        pid: json["pid"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
        "points": points,
        "type": type,
        "pid": pid,
        "date": date,
        "time": time,
      };
}
