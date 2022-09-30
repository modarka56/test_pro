// To parse this JSON data, do
//
//     final exrciesModule = exrciesModuleFromJson(jsonString);

import 'dart:convert';

ExrciesModule exrciesModuleFromJson(String str) => ExrciesModule.fromJson(json.decode(str));

String exrciesModuleToJson(ExrciesModule data) => json.encode(data.toJson());

class ExrciesModule {
  ExrciesModule({
    this.id,
    this.level,
    this.exerciseName,
    this.urlImage,
    this.urlVideo,
    this.details,
    this.type,
    this.musclesLearned,
    this.numberOfTraining,
    required this.lock
  });

  String? id;
  int? level;
  String? exerciseName;
  String? urlImage;
  String? urlVideo;
  String? details;
  String? type;
  List? musclesLearned;
  String? numberOfTraining;
  bool lock;

  factory ExrciesModule.fromJson(Map<String, dynamic> json) => ExrciesModule(
    id: json["id"],
    level: json["level"],
    exerciseName: json["exerciseName"],
    urlImage: json["urlImage"],
    urlVideo: json["urlVideo"],
    details: json["details"],
    type: json["type"],
    musclesLearned: json["musclesLearned"],
    numberOfTraining: json["numberOfTraining"], lock: json["lock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "level": level,
    "exerciseName": exerciseName,
    "urlImage": urlImage,
    "urlVideo": urlVideo,
    "details": details,
    "type": type,
    "musclesLearned": musclesLearned,
    "numberOfTraining": numberOfTraining,
    "lock":lock
  };
}
