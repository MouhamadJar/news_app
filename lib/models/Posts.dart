import 'package:news_app/models/Comments.dart';

import 'IsLike.dart';
import 'User.dart';

class Posts {
  Posts({
    required this.id,
    required this.body,
    required this.video,
    required this.user,
    required this.likes,
    required this.desLike,
    required this.isLike,
    required this.comments,
  });

  late int id;
  late String body;
  late String video;
  late User user;
  late int likes;
  late int desLike;
  late List<dynamic> isLike;
  late List<dynamic> comments;

  Posts.fromJson(dynamic json) {
    id = json['id'];
    body = json['body'];
    video = json['video'];
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
    likes = json['likes'];
    desLike = json['desLike'];
    if (json['is_like'] != null) {
      isLike = [];
      json['is_like'].forEach((v) {
        isLike.add(IsLike.fromJson(v));
      });
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
    map['body'] = body;
    map['video'] = video;
    if (user != null) {
      map['user'] = user.toJson();
    }
    map['likes'] = likes;
    map['desLike'] = desLike;
    if (isLike != null) {
      map['is_like'] = isLike.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      map['comments'] = comments.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
