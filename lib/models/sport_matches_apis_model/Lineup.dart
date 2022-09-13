import 'Home.dart';
import 'Away.dart';

class Lineup {
  Lineup({
    required  this.home,
    required  this.away,});
  late  Home home;
  late  Away away;
  Lineup.fromJson(dynamic json) {
    home = (json['home'] != null ? Home.fromJson(json['home']) : null)!;
    away = (json['away'] != null ? Away.fromJson(json['away']) : null)!;
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (home != null) {
      map['home'] = home.toJson();
    }
    if (away != null) {
      map['away'] = away.toJson();
    }
    return map;
  }

}