class UserModel {
  UserModel({
     required this.id,
    required this.email,
    required this.userName,
    required this.country,
    required this.phone,
    required this.image,});

late  int id;
  late  String email;
  late String userName;
  late String image;
  late String phone;
  late String country;

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    userName = json['user_name'];
    image = json['image'];
    country = json['country'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['phone'] = phone;
    map['country'] = country;
    map['user_name'] = userName;
    map['image'] = image;
    return map;
  }

}