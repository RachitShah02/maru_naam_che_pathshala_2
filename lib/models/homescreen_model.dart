// To parse this JSON data, do
//
//     final homeScreenModel = homeScreenModelFromJson(jsonString);

import 'dart:convert';

HomeScreenModel homeScreenModelFromJson(String str) =>
    HomeScreenModel.fromJson(json.decode(str));

String homeScreenModelToJson(HomeScreenModel data) =>
    json.encode(data.toJson());

class HomeScreenModel {
  final List<Attendence>? attendence;
  final List<Slider>? slider;
  final List<Point>? currentPoints;
  final List<Point>? totalPoints;
  final List<Sutra>? sutra;

  HomeScreenModel({
    this.attendence,
    this.slider,
    this.currentPoints,
    this.totalPoints,
    this.sutra,
  });

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenModel(
        attendence: json["attendence"] == null
            ? []
            : List<Attendence>.from(
                json["attendence"]!.map((x) => Attendence.fromJson(x))),
        slider: json["slider"] == null
            ? []
            : List<Slider>.from(json["slider"]!.map((x) => Slider.fromJson(x))),
        currentPoints: json["current_points"] == null
            ? []
            : List<Point>.from(
                json["current_points"]!.map((x) => Point.fromJson(x))),
        totalPoints: json["total_points"] == null
            ? []
            : List<Point>.from(
                json["total_points"]!.map((x) => Point.fromJson(x))),
        sutra: json["sutra"] == null
            ? []
            : List<Sutra>.from(json["sutra"]!.map((x) => Sutra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attendence": attendence == null
            ? []
            : List<dynamic>.from(attendence!.map((x) => x.toJson())),
        "slider": slider == null
            ? []
            : List<dynamic>.from(slider!.map((x) => x.toJson())),
        "current_points": currentPoints == null
            ? []
            : List<dynamic>.from(currentPoints!.map((x) => x.toJson())),
        "total_points": totalPoints == null
            ? []
            : List<dynamic>.from(totalPoints!.map((x) => x.toJson())),
        "sutra": sutra == null
            ? []
            : List<dynamic>.from(sutra!.map((x) => x.toJson())),
      };
}

class Attendence {
  final String? date;
  final String? status;

  Attendence({
    this.date,
    this.status,
  });

  factory Attendence.fromJson(Map<String, dynamic> json) => Attendence(
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
      };
}

class Point {
  final String? totalPoints;

  Point({
    this.totalPoints,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        totalPoints: json["total_points"],
      );

  Map<String, dynamic> toJson() => {
        "total_points": totalPoints,
      };
}

class Slider {
  final int? id;
  final String? img;
  final String? type;
  final String? target;

  Slider({
    this.id,
    this.img,
    this.type,
    this.target,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        img: json["img"],
        type: json["type"],
        target: json["target"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "type": type,
        "target": target,
      };
}

class Sutra {
  final int? id;
  final String? sid;
  final int? sutraId;
  final String? sutra;
  final String? date;
  final String? time;

  Sutra({
    this.id,
    this.sid,
    this.sutraId,
    this.sutra,
    this.date,
    this.time,
  });

  factory Sutra.fromJson(Map<String, dynamic> json) => Sutra(
        id: json["id"],
        sid: json["sid"],
        sutraId: json["sutra_id"],
        sutra: json["sutra"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sid": sid,
        "sutra_id": sutraId,
        "sutra": sutra,
        "date": date,
        "time": time,
      };
}
