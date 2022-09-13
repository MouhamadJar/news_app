import 'Files.dart';

class LessonModel {
  LessonModel({
      required this.id,
      required this.name,
      required this.files,});

  late int id;
  late String name;
  late List<Files> files;

  LessonModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (!json['files'].isEmpty) {
      files = [];
      json['files'].forEach((v) {
        files.add(Files.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['files'] = files.map((v) => v.toJson()).toList();
    return map;
  }

}