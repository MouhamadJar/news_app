import 'Home.dart';
import 'Away.dart';

class Substitutions {
  Substitutions({
    required   this.home,
    required  this.away,});

  Substitutions.fromJson(dynamic json) {
    if (json['home'] != null) {
      home = [];
      json['home'].forEach((v) {
        home.add(v);
      });
    }
    if (json['away'] != null) {
      away = [];
      json['away'].forEach((v) {
        away.add(v);
      });
    }
  }
  late List<Map<String,dynamic>> home;
  late List<Map<String,dynamic>> away;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (home != null) {
      map['home'] = home.map((v) => v).toList();
    }
    if (away != null) {
      map['away'] = away.map((v) => v).toList();
    }
    return map;
  }

}