import 'dart:convert';

List<LabharthiModal> labharthiModallFromJson(String str) =>
    List<LabharthiModal>.from(
        json.decode(str).map((x) => LabharthiModal.fromJson(x)));

class LabharthiModal {
  final String? name;
  final String? tithi;
  final String? nimit;
  final String? amount;
  final String? date;

  LabharthiModal({
    this.name,
    this.amount,
    this.tithi,
    this.nimit,
    this.date,
  });

  factory LabharthiModal.fromJson(Map<String, dynamic> json) => LabharthiModal(
        name: json["name"] ?? '',
        amount: json["amt"] ?? '',
        tithi: json["tithi"] ?? '',
        nimit: json["nimit"] ?? '',
        date: json["date"] ?? '',
      );
}
// To parse this JSON data, do
//
//     final rewardsModel = rewardsModelFromJson(jsonString);

List<RewardsModel> rewardsModelFromJson(String str) => List<RewardsModel>.from(
    json.decode(str).map((x) => RewardsModel.fromJson(x)));

String rewardsModelToJson(List<RewardsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardsModel {
  final int? id;
  final String? reward;
  final int? points;
  final int? amount;
  final String? img;

  RewardsModel({
    this.id,
    this.reward,
    this.points,
    this.amount,
    this.img,
  });

  factory RewardsModel.fromJson(Map<String, dynamic> json) => RewardsModel(
        id: json["id"],
        reward: json["reward"],
        points: json["points"],
        amount: json["amount"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reward": reward,
        "points": points,
        "amount": amount,
        "img": img,
      };
}
