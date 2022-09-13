import 'User.dart';

class Comments {
  Comments({
      required this.comment,
      required this.user,
  });
  late String comment;
  late User user;

  Comments.fromJson(dynamic json) {
    comment = json['comment'];
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = comment;
    if (user != null) {
      map['user'] = user.toJson();
    }
    return map;
  }

}