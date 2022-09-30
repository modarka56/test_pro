// To parse this JSON data, do
//
//     final postModule = postModuleFromJson(jsonString);

import 'dart:convert';

PostModule postModuleFromJson(String str) => PostModule.fromJson(json.decode(str));

String postModuleToJson(PostModule data) => json.encode(data.toJson());

class PostModule {
  PostModule({
    this.title,
    this.message,
    this.groupimage,
    this.image,
    this.vedio,
    this.text,
    this.date,
    this.type
  });

  String? title;
  String? message;
  String? groupimage;
  String? image;
  String? vedio;
  String? text;
  String? date;
  String? type;

  factory PostModule.fromJson(Map<String, dynamic> json) => PostModule(
    title: json["title"],
    message: json["message"],
    groupimage: json["groupimage"],
    image: json["image"],
    vedio: json["vedio"],
    text: json["text"],
    date: json["date"],
      type:json["type"]
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "groupimage": groupimage,
    "image": image,
    "vedio": vedio,
    "text": text,
    "date": date,
    "type":type
  };
}
