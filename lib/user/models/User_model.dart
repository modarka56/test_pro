// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
     required this.phone,
    required this.age,
    required this.lastonline,
    required this.online,
    required this.image,
    required this.email,
    required this.password,
    required this.level,
    required this.hight,
    required this.weight,
    required this.sex,
    required this.country,
    required this.type,
    required this.musclesinjured,
    required this.ingroup,
    required this.groupid,

  });

  String name;

  int age;
  Lastonline lastonline;
  bool online;
  String image;
  String email;
  String password;
  int level;
  int hight;
  int weight;
  String sex;
  String country;
  String type;
  String phone;
  List musclesinjured;
  String ingroup;
  String groupid;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    phone:json["phone"],
    age: json["age"],
    lastonline: Lastonline.fromJson(json["lastonline"]),
    online: json["online"],
    image: json["image"],
    email: json["email"],
    password: json["password"],
    level: json["level"],
    hight: json["hight"],
    weight: json["weight"],
    sex: json["sex"],
    country: json["country"],
    type: json["type"],
    musclesinjured: json["musclesinjured"],
    ingroup: json["ingroup"],
    groupid: json["groupid"],
  );

  Map<String, dynamic> toJson() => {
  "name":name,
    "age": age,
    "phone":phone,
    "lastonline": lastonline.toJson(),
    "online": online,
    "image": image,
    "email": email,
    "password": password,
    "level": level,
    "hight": hight,
    "weight": weight,
    "sex": sex,
    "country": country,
    "type": type,
    "musclesinjured":musclesinjured,
    "groupid":groupid,
    "ingroup":ingroup,


  };
}

class Lastonline {
  Lastonline({
    this.day,
    this.month,
    this.year,
  });

  int? day;
  int? month;
  int? year;

  factory Lastonline.fromJson(Map<String, dynamic> json) => Lastonline(
    day: json["day"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "month": month,
    "year": year,
  };
}
