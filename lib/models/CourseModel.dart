import 'Images.dart';
import 'Comments.dart';
import 'IsLike.dart';

class CourseModel {
  CourseModel({
    required this.id,
    required this.name,
    required this.details,
    required this.images,
    required this.comments,
    required this.likes,
    required this.isLike,
    required this.desLike,
    required this.successRate,
  });
  late int id;
  late String name;
  late String details;
  late List<Images> images;
  late List<Comments> comments;
  late int likes;
  late int desLike;
  late int successRate;
  late List<IsLike> isLike;

  CourseModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    successRate =int.parse( json['successRate']);
    details = json['details'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(Comments.fromJson(v));
      });
    }
    likes = json['likes'];
    desLike = json['desLike'];
    if (json['is_like'] != null) {
      isLike = [];
      json['is_like'].forEach((v) {
        isLike.add(IsLike.fromJson(v));
      });
    }
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['details'] = details;
    if (images != null) {
      map['images'] = images.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      map['comments'] = comments.map((v) => v.toJson()).toList();
    }
    map['likes'] = likes;
    if (isLike != null) {
      map['is_like'] = isLike.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
