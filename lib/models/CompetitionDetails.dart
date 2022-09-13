import 'Posts.dart';

class AllCompetitionDetails {
  AllCompetitionDetails({
    required this.id,
    required this.name,
    required this.details,
    required this.prize,
    required this.posts,
  });

  late int id;
  late String name;
  late String details;
  late String prize;
  late List<Posts> posts;

  AllCompetitionDetails.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    prize = json['prize'];
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['details'] = details;
    map['prize'] = prize;
    if (posts != null) {
      map['posts'] = posts.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
