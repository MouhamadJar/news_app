class Statistics1half {
  Statistics1half({
    required this.type,
    required this.home,
    required this.away,
  });

  Statistics1half.fromJson(dynamic json) {
    type = json['type'];
    home = json['home'];
    away = json['away'];
  }

  late String type;
  late String home;
  late String away;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['home'] = home;
    map['away'] = away;
    return map;
  }
}
