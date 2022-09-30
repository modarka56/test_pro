// To parse this JSON data, do
//
//     final adminModule = adminModuleFromJson(jsonString);

import 'dart:convert';

AdminModule adminModuleFromJson(String str) => AdminModule.fromJson(json.decode(str));

String adminModuleToJson(AdminModule data) => json.encode(data.toJson());

class AdminModule {
  AdminModule( {
    this.name,
    this.email,
    this.password,
    this.phone,
    this.type
  });

  String? name;
  String? email;
  String? password;
  String? phone;
  String? type;

  factory AdminModule.fromJson(Map<String, dynamic> json) => AdminModule(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
      type:json["type"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "phone": phone,
    "type":type
  };
}
