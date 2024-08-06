// To parse this JSON data, do
//
//     final parentsPointsModel = parentsPointsModelFromJson(jsonString);

import 'dart:convert';

List<ParentsPointsModel> parentsPointsModelFromJson(String str) =>
    List<ParentsPointsModel>.from(
        json.decode(str).map((x) => ParentsPointsModel.fromJson(x)));

String parentsPointsModelToJson(List<ParentsPointsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParentsPointsModel {
  final String? id;
  final String? details;
  final String? points;
  final String? type;
  final String? status;

  ParentsPointsModel({
    this.id,
    this.details,
    this.points,
    this.type,
    this.status,
  });

  factory ParentsPointsModel.fromJson(Map<String, dynamic> json) =>
      ParentsPointsModel(
        id: json["id"],
        details: json["details"],
        points: json["points"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
        "points": points,
        "type": type,
        "status": status,
      };
}

// To parse this JSON data, do
//
//     final addPointsResponseModel = addPointsResponseModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final addPointsResponseModel = addPointsResponseModelFromJson(jsonString);

AddPointsResponseModel addPointsResponseModelFromJson(String str) =>
    AddPointsResponseModel.fromJson(json.decode(str));

String addPointsResponseModelToJson(AddPointsResponseModel data) =>
    json.encode(data.toJson());

class AddPointsResponseModel {
  final bool? add;
  final AddData? data;

  AddPointsResponseModel({
    this.add,
    this.data,
  });

  factory AddPointsResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPointsResponseModel(
        add: json["add"],
        data: json["data"] == null ? null : AddData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "add": add,
        "data": data?.toJson(),
      };
}

class AddData {
  final String? pid;
  final String? status;

  AddData({
    this.pid,
    this.status,
  });

  factory AddData.fromJson(Map<String, dynamic> json) => AddData(
        pid: json["pid"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "status": status,
      };
}
