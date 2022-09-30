// To parse this JSON data, do
//
//     final joinreqModule = joinreqModuleFromJson(jsonString);

import 'dart:convert';

JoinreqModule joinreqModuleFromJson(String str) => JoinreqModule.fromJson(json.decode(str));

String joinreqModuleToJson(JoinreqModule data) => json.encode(data.toJson());

class JoinreqModule {
  JoinreqModule({
    this.title,
    this.message,
    this.playerimage,
    this.phone,
    this.email,
    this.level,
    this.date,
    this.type,
    this.status
  });

  String? title;
  String? message;
  String? playerimage;
  String? phone;
  String? email;
  String? level;
  String? date;
  String? type;
  String? status;

  factory JoinreqModule.fromJson(Map<String, dynamic> json) => JoinreqModule(
    title: json["title"],
    message: json["message"],
    playerimage: json["playerimage"],
    phone: json["phone"],
    email: json["email"],
    level: json["level"],
    date: json["date"],
    type: json["type"],
      status:json["status"]
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "playerimage": playerimage,
    "phone": phone,
    "email": email,
    "level": level,
    "date": date,
    "type": type,
    "status":status
  };
}
