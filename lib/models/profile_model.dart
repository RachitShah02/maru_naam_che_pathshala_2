import 'dart:convert';

import 'homescreen_model.dart';
import 'student_model.dart';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final StudentModel? student;
  final Pathshala? pathshala;
  final Sutra? sutra;
  final int? totalAttendence;
  final String? totalPoints;

  ProfileModel({
    this.student,
    this.pathshala,
    this.sutra,
    this.totalAttendence,
    this.totalPoints,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        student: json["student"] == null
            ? null
            : StudentModel.fromJson(json["student"]),
        pathshala: json["pathshala"] == null
            ? null
            : Pathshala.fromJson(json["pathshala"]),
        sutra: json["sutra"] == null ? null : Sutra.fromJson(json["sutra"]),
        totalAttendence: json["total_attendence"],
        totalPoints: json["total_points"],
      );

  Map<String, dynamic> toJson() => {
        "student": student?.toJson(),
        "pathshala": pathshala?.toJson(),
        "sutra": sutra?.toJson(),
        "total_attendence": totalAttendence,
        "total_points": totalPoints,
      };
}