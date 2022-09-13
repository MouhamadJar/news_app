import 'package:news_app/models/components/constants.dart';

class RoomModel {
  RoomModel({
     required this.id,
    required this.name,
    required this.image,});
 late int id;
  late String name;
  late  String image;
  late  String color;
  RoomModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    color = '0xFF${json['color']}';
    image ='$imageURL/${json['image']}';
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}