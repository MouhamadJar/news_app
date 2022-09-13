class Cards {
  Cards({
    required this.time,
    required this.homeFault,
    required this.card,
    required this.awayFault,
    required this.info,
    required this.homePlayerId,
    required this.awayPlayerId,
    required this.scoreInfoTime,
  });

  late String time;
  late String homeFault;
  late String card;
  late String awayFault;
  late String info;
  late String homePlayerId;
  late String awayPlayerId;
  late String scoreInfoTime;

  Cards.fromJson(dynamic json) {
    time = json['time'];
    homeFault = json['home_fault'];
    card = json['card'];
    awayFault = json['away_fault'];
    info = json['info'];
    homePlayerId = json['home_player_id'];
    awayPlayerId = json['away_player_id'];
    scoreInfoTime = json['score_info_time'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['home_fault'] = homeFault;
    map['card'] = card;
    map['away_fault'] = awayFault;
    map['info'] = info;
    map['home_player_id'] = homePlayerId;
    map['away_player_id'] = awayPlayerId;
    map['score_info_time'] = scoreInfoTime;
    return map;
  }
}
