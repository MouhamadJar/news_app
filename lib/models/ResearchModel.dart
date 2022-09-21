import 'Images.dart';
import 'Comments.dart';

class ResearchModel {
  ResearchModel({
    required this.id,
    required this.title,
    required this.body,
    required this.link,
    required this.countOfVisitors,
    required this.author,
    required this.images,
    required this.likes,
    required this.dislikes,
    required this.isLike,
    required this.comments,
  });

  late int id;
  late String title;
  late String body;
  late dynamic link;
  late List<dynamic> countOfVisitors;
  late String author;
  late List<Images> images;
  late int likes;
  late int dislikes;
  late dynamic isLike;
  late List<Comments> comments;

  ResearchModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    link = json['link'];
    countOfVisitors = json['CountOfVisitors'] ?? ['0'];
    author = json['author'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    likes = json['likes'];
    dislikes = json['desLike'];
    if (json['is_like'] != null) {
      if (json['is_like'].toString() == '[]') {
        isLike = 2;
      } else {
        isLike = json['is_like'];
      }
    } else {
      isLike = 2;
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    map['link'] = link;
    map['CountOfVisitors'] = countOfVisitors;
    map['author'] = author;
    if (images != null) {
      map['images'] = images.map((v) => v.toJson()).toList();
    }
    map['likes'] = likes;
    map['is_like'] = isLike;
    if (comments != null) {
      map['comments'] = comments.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
