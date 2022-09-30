// To parse this JSON data, do
//
//     final groupModule = groupModuleFromJson(jsonString);

import 'dart:convert';

GroupModule groupModuleFromJson(String str) => GroupModule.fromJson(json.decode(str));

String groupModuleToJson(GroupModule data) => json.encode(data.toJson());

class GroupModule {
  GroupModule({
    this.name,
    this.image,
    this.cert,
    this.id,
    this.level,
    this.numberofplayers,
    this.onwername,
    this.status,
    this.email,
    this.phone,
    this.bio
  });

  String? name;
  String? image;
  String? cert;
  String? id;
  String? level;
  String? numberofplayers;
  String? status;
  String? onwername;
  String? email;
  String? phone;
  String? bio;

  factory GroupModule.fromJson(Map<String, dynamic> json) => GroupModule(
    name: json["name"],
    image: json["image"],
    cert: json["cert"],
    id: json["id"],
    level: json["level"],
    numberofplayers: json["numberofplayers"],
    onwername: json["onwername"],
      status:json["status"],
      phone:json["phone"],
      email:json["email"],
      bio:json["bio"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "cert": cert,
    "id": id,
    "level": level,
    "numberofplayers": numberofplayers,
    "onwername": onwername,
    "status":status,
    "phone":phone,
    "email":email,
    "bio":bio
  };
}
