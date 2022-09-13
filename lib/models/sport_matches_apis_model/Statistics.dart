class Statistics {
  Statistics({
    required  this.type,
    required   this.home,
    required   this.away,});
  late  String type;
  late String home;
  late String away;
  Statistics.fromJson(dynamic json) {
    type = json['type'];
    home = json['home'];
    away = json['away'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['home'] = home;
    map['away'] = away;
    return map;
  }

}