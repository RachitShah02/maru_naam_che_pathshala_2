// To parse this JSON data, do
//
//     final ledgerModel = ledgerModelFromJson(jsonString);

import 'dart:convert';

LedgerModel ledgerModelFromJson(String str) =>
    LedgerModel.fromJson(json.decode(str));

String ledgerModelToJson(LedgerModel data) => json.encode(data.toJson());

class LedgerModel {
  final List<AllTop>? allTop;
  final List<AllTop>? myPath;

  LedgerModel({
    this.allTop,
    this.myPath,
  });

  factory LedgerModel.fromJson(Map<String, dynamic> json) => LedgerModel(
        allTop: json["ALL_TOP"] == null
            ? []
            : List<AllTop>.from(
                json["ALL_TOP"]!.map((x) => AllTop.fromJson(x))),
        myPath: json["MY_PATH"] == null
            ? []
            : List<AllTop>.from(
                json["MY_PATH"]!.map((x) => AllTop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ALL_TOP": allTop == null
            ? []
            : List<dynamic>.from(allTop!.map((x) => x.toJson())),
        "MY_PATH": myPath == null
            ? []
            : List<dynamic>.from(myPath!.map((x) => x.toJson())),
      };
}

class AllTop {
  final String? sid;
  final String? totalPoints;
  final String? name;
  final String? pathshala;

  AllTop({
    this.sid,
    this.totalPoints,
    this.name,
    this.pathshala,
  });

  factory AllTop.fromJson(Map<String, dynamic> json) => AllTop(
        sid: json["sid"],
        totalPoints: json["total_points"],
        name: json["name"],
        pathshala: json["pathshala"],
      );

  Map<String, dynamic> toJson() => {
        "sid": sid,
        "total_points": totalPoints,
        "name": name,
        "pathshala": pathshala,
      };
}
