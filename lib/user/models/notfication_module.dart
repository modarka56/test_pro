// To parse this JSON data, do
//
//     final notfiModule = notfiModuleFromJson(jsonString);

import 'dart:convert';

NotfiModule notfiModuleFromJson(String str) => NotfiModule.fromJson(json.decode(str));

String notfiModuleToJson(NotfiModule data) => json.encode(data.toJson());

class NotfiModule {
  NotfiModule({
    this.title,
    this.date,
    this.message,
    this.bywho, required this.type,
  });

  String? title;
  String? date;
  String? message;
  String? bywho;
  String? type;

  factory NotfiModule.fromJson(Map<String, dynamic> json) => NotfiModule(
    title: json["title"],
    date: json["date"],
    message: json["message"],
    bywho: json["bywho"],
      type:json["type"]
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "date": date,
    "message": message,
    "bywho": bywho,
    "type":type
  };
}
