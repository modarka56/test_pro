// To parse this JSON data, do
//
//     final groupinfoModule = groupinfoModuleFromJson(jsonString);

import 'dart:convert';

GroupinfoModule groupinfoModuleFromJson(String str) => GroupinfoModule.fromJson(json.decode(str));

String groupinfoModuleToJson(GroupinfoModule data) => json.encode(data.toJson());

class GroupinfoModule {
  GroupinfoModule({
    required this.name,
    required this.level,
    required this.onwername,
    required this.image,
    required this.bio,
    required this.email
  });

  String name;
  String level;
  String onwername;
  String image;
  String bio;
  String email;

  factory GroupinfoModule.fromJson(Map<String, dynamic> json) => GroupinfoModule(
    name: json["name"],
    level: json["level"],
    onwername: json["onwername"],
    image: json["image"],
    bio: json["bio"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "level": level,
    "onwername": onwername,
    "image": image,
    "bio": bio,
    "email": email,
  };
}
