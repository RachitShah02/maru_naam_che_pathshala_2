// To parse this JSON data, do
//
//     final attendenceCalanderModel = attendenceCalanderModelFromJson(jsonString);

import 'dart:convert';

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

List<AttendenceListModel> attendenceListModelFromJson(String str) =>
    List<AttendenceListModel>.from(
        json.decode(str).map((x) => AttendenceListModel.fromJson(x)));

String attendenceListModelToJson(List<AttendenceListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendenceListModel {
  final String? month;
  final int? attendance;
  final String? totalPoints;
  final int? totalDays;
  final String? year;

  AttendenceListModel({
    this.month,
    this.attendance,
    this.totalPoints,
    this.totalDays,
    this.year,
  });

  factory AttendenceListModel.fromJson(Map<String, dynamic> json) =>
      AttendenceListModel(
        month: json["month"],
        attendance: json["attendance"],
        totalPoints: json["total_points"],
        totalDays: json["totalDays"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "attendance": attendance,
        "total_points": totalPoints,
        "totalDays": totalDays,
        "year": year,
      };
}
