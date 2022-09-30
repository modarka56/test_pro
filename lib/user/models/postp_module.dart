// To parse this JSON data, do
//
//     final postpModule = postpModuleFromJson(jsonString);

import 'dart:convert';

PostpModule postpModuleFromJson(String str) => PostpModule.fromJson(json.decode(str));

String postpModuleToJson(PostpModule data) => json.encode(data.toJson());

class PostpModule {
  PostpModule({
    this.title,
    this.message,
    this.video,
    this.date,
    this.rating,
    required this.rated
  });

  String? title;
  String? message;
  String? video;
  String? date;
  double? rating;
  bool? rated;

  factory PostpModule.fromJson(Map<String, dynamic> json) => PostpModule(
    title: json["title"],
    message: json["message"],
    video: json["video"],
    date: json["date"],
    rating: json["rating"], rated: json["rated"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "video": video,
    "date": date,
    "rating": rating,
    "rated":rated
  };
}
