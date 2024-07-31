import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  final String? fullName;
  final String? fullAddress;
  final String? birthdate;
  final String? mo1;
  final String? mo2;
  final String? img;
  final String? pathshala;
  final String? pathshalaTime;
  final int? pathshalaId;

  StudentModel({
    this.fullName,
    this.fullAddress,
    this.birthdate,
    this.mo1,
    this.mo2,
    this.img,
    this.pathshala,
    this.pathshalaTime,
    this.pathshalaId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        fullName: json["full_name"],
        fullAddress: json["full_address"],
        birthdate: json["birthdate"],
        mo1: json["mo_1"],
        mo2: json["mo_2"],
        img: json["img"],
        pathshala: json["pathshala"],
        pathshalaTime: json["pathshala_time"],
        pathshalaId: json["pathshala_id"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "full_address": fullAddress,
        "birthdate": birthdate,
        "mo_1": mo1,
        "mo_2": mo2,
        "img": img,
        "pathshala": pathshala,
        "pathshala_time": pathshalaTime,
        "pathshala_id": pathshalaId,
      };
}
