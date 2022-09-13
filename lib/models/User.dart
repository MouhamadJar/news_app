class User {
  User({
    required this.id,
    required this.userName,
    required this.image,
  });


  late int id;
  late String userName;
  late String image;

  User.fromJson(dynamic json) {
    id = json['id'];
    userName = json['user_name'];
    image = json['image'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_name'] = userName;
    map['image'] = image;
    return map;
  }
}
