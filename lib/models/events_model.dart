// To parse this JSON data, do
//
//     final eventsModel = eventsModelFromJson(jsonString);

import 'dart:convert';

List<EventsModel> eventsModelFromJson(String str) => List<EventsModel>.from(
    json.decode(str).map((x) => EventsModel.fromJson(x)));

String eventsModelToJson(List<EventsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

EventsModel eventModelFromJson(String str) =>
    EventsModel.fromJson(json.decode(str));

class EventsModel {
  final int? id;
  final String? title;
  final String? description;
  final String? link;
  final String? img;
  final String? datetime;

  EventsModel({
    this.id,
    this.title,
    this.description,
    this.link,
    this.img,
    this.datetime,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        link: json["link"],
        img: json["img"],
        datetime: json["datetime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "link": link,
        "img": img,
        "datetime": datetime,
      };
}
