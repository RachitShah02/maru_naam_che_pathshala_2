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

// To parse this JSON data, do
//
//     final attendenceListModel = attendenceListModelFromJson(jsonString);

AttendenceListModel attendenceListModelFromJson(String str) =>
    AttendenceListModel.fromJson(json.decode(str));

String attendenceListModelToJson(AttendenceListModel data) =>
    json.encode(data.toJson());

class AttendenceListModel {
  final List<AttListElement>? list;
  final int? total;

  AttendenceListModel({
    this.list,
    this.total,
  });

  factory AttendenceListModel.fromJson(Map<String, dynamic> json) =>
      AttendenceListModel(
        list: json["list"] == null
            ? []
            : List<AttListElement>.from(
                json["list"]!.map((x) => AttListElement.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "total": total,
      };
}

class AttListElement {
  final String? month;
  final int? attendance;
  final String? totalPoints;
  final int? totalDays;
  final String? year;

  AttListElement({
    this.month,
    this.attendance,
    this.totalPoints,
    this.totalDays,
    this.year,
  });

  factory AttListElement.fromJson(Map<String, dynamic> json) => AttListElement(
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
