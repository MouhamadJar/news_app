import 'Images.dart';

class CompetitionModel {
  CompetitionModel({
    required this.id,
    required this.name,
    required this.details,
    required this.prize,
    required this.images,
  });

  late int id;
  late String name;
  late String details;
  late String prize;
  late List<Images> images;

  CompetitionModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    prize = json['prize'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['details'] = details;
    map['prize'] = prize;
    if (images != null) {
      map['images'] = images.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
