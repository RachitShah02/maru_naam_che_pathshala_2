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
  final TotalAttendence? totalAttendence;
  final List<HomeSlider>? slider;
  final String? currentPoints;
  final String? totalPoints;
  final Sutra? sutra;
  final Pathshala? pathshala;

  HomeScreenModel({
    this.attendence,
    this.totalAttendence,
    this.slider,
    this.currentPoints,
    this.totalPoints,
    this.sutra,
    this.pathshala,
  });

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenModel(
        attendence: json["attendence"] == null
            ? []
            : List<Attendence>.from(
                json["attendence"]!.map((x) => Attendence.fromJson(x))),
        totalAttendence: json["total_attendence"] == null
            ? null
            : TotalAttendence.fromJson(json["total_attendence"]),
        slider: json["slider"] == null
            ? []
            : List<HomeSlider>.from(
                json["slider"]!.map((x) => HomeSlider.fromJson(x))),
        currentPoints: json["current_points"],
        totalPoints: json["total_points"],
        sutra: json["sutra"] == null ? null : Sutra.fromJson(json["sutra"]),
        pathshala: json["pathshala"] == null
            ? null
            : Pathshala.fromJson(json["pathshala"]),
      );

  Map<String, dynamic> toJson() => {
        "attendence": attendence == null
            ? []
            : List<dynamic>.from(attendence!.map((x) => x.toJson())),
        "total_attendence": totalAttendence!.toJson(),
        "slider": slider == null
            ? []
            : List<dynamic>.from(slider!.map((x) => x.toJson())),
        "current_points": currentPoints,
        "total_points": totalPoints,
        "sutra": sutra?.toJson(),
        "pathshala": pathshala?.toJson(),
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

class TotalAttendence {
  final int? attendance;
  final int? days;
  TotalAttendence({
    this.attendance,
    this.days,
  });

  factory TotalAttendence.fromJson(Map<String, dynamic> json) =>
      TotalAttendence(attendance: json["attendance"], days: json["days"]);

  Map<String, dynamic> toJson() => {"attendance": attendance, "days": days};
}

class HomeSlider {
  final int? id;
  final String? img;
  final String? type;
  final String? target;

  HomeSlider({
    this.id,
    this.img,
    this.type,
    this.target,
  });

  factory HomeSlider.fromJson(Map<String, dynamic> json) => HomeSlider(
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
  final int? gatha;
  final String? date;
  final String? time;

  Sutra({
    this.id,
    this.sid,
    this.sutraId,
    this.sutra,
    this.gatha,
    this.date,
    this.time,
  });

  factory Sutra.fromJson(Map<String, dynamic> json) => Sutra(
        id: json["id"],
        sid: json["sid"],
        sutraId: json["sutra_id"],
        sutra: json["sutra"],
        gatha: json["gatha"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sid": sid,
        "sutra_id": sutraId,
        "sutra": sutra,
        "gatha": gatha,
        "date": date,
        "time": time,
      };
}

class Pathshala {
  final String? pathshala;
  final String? time;
  final String? panditji;
  final String? mobile;
  Pathshala({
    this.pathshala,
    this.time,
    this.panditji,
    this.mobile,
  });
  factory Pathshala.fromJson(Map<String, dynamic> json) => Pathshala(
      pathshala: json["pathshala"],
      panditji: json["panditji"],
      time: json["time"],
      mobile: json["mobile"]);

  Map<String, dynamic> toJson() => {
        "pathshala": pathshala,
        "panditji": panditji,
        "mobile": mobile,
        "time": time,
      };
}
