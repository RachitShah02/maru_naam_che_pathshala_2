// To parse this JSON data, do
//
//     final sutraListModel = sutraListModelFromJson(jsonString);

import 'dart:convert';

List<SutraListModel> sutraListModelFromJson(String str) =>
    List<SutraListModel>.from(
        json.decode(str).map((x) => SutraListModel.fromJson(x)));

String sutraListModelToJson(List<SutraListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SutraListModel {
  final int? id;
  final String? sid;
  final int? sutraId;
  final String? sutra;
  final String? date;
  final String? time;
  final String? points;
  final String? gatha;

  SutraListModel({
    this.id,
    this.sid,
    this.sutraId,
    this.sutra,
    this.date,
    this.time,
    this.points,
    this.gatha,
  });

  factory SutraListModel.fromJson(Map<String, dynamic> json) => SutraListModel(
        id: json["id"],
        sid: json["sid"],
        sutraId: json["sutra_id"],
        sutra: json["sutra"],
        date: json["date"],
        time: json["time"],
        points: json["points"],
        gatha: json["gatha"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sid": sid,
        "sutra_id": sutraId,
        "sutra": sutra,
        "date": date,
        "time": time,
        "points": points,
        "gatha": gatha,
      };
}
