// To parse this JSON data, do
//
//     final attendenceCalanderModel = attendenceCalanderModelFromJson(jsonString);

import 'dart:convert';

import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

List<AttendenceCalanderModel> attendenceCalanderModelFromJson(String str) =>
    List<AttendenceCalanderModel>.from(
        json.decode(str).map((x) => AttendenceCalanderModel.fromJson(x)));

String attendenceCalanderModelToJson(List<AttendenceCalanderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendenceCalanderModel {
  final String? date;
  final String? status;

  AttendenceCalanderModel({
    this.date,
    this.status,
  });

  factory AttendenceCalanderModel.fromJson(Map<String, dynamic> json) =>
      AttendenceCalanderModel(
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
      };
}

// To parse this JSON data, do
//
//     final attendenceListModel = attendenceListModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final attendenceListModel = attendenceListModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final attendenceListModel = attendenceListModelFromJson(jsonString);

AttendenceListModel attendenceListModelFromJson(String str) =>
    AttendenceListModel.fromJson(json.decode(str));

String attendenceListModelToJson(AttendenceListModel data) =>
    json.encode(data.toJson());

class AttendenceListModel {
  final List<AttendenceListModelList>? list;
  final int? total;
  final List<String>? yearlist;

  AttendenceListModel({
    this.list,
    this.total,
    this.yearlist,
  });

  factory AttendenceListModel.fromJson(Map<String, dynamic> json) =>
      AttendenceListModel(
        list: json["list"] == null
            ? []
            : List<AttendenceListModelList>.from(
                json["list"]!.map((x) => AttendenceListModelList.fromJson(x))),
        total: json["total"],
        yearlist: json["yearlist"] == null
            ? []
            : List<String>.from(json["yearlist"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "total": total,
        "yearlist":
            yearlist == null ? [] : List<dynamic>.from(yearlist!.map((x) => x)),
      };
}

class AttendenceListModelList {
  final String? month;
  final int? attendance;
  final String? totalPoints;
  final int? totalDays;
  final String? year;
  final List<Attendence>? list;

  AttendenceListModelList({
    this.month,
    this.attendance,
    this.totalPoints,
    this.totalDays,
    this.year,
    this.list,
  });

  factory AttendenceListModelList.fromJson(Map<String, dynamic> json) =>
      AttendenceListModelList(
        month: json["month"],
        attendance: json["attendance"],
        totalPoints: json["total_points"],
        totalDays: json["totalDays"],
        year: json["year"],
        list: json["list"] == null
            ? []
            : List<Attendence>.from(
                json["list"]!.map((x) => Attendence.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "attendance": attendance,
        "total_points": totalPoints,
        "totalDays": totalDays,
        "year": year,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}
