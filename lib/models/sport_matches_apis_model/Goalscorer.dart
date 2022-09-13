class Goalscorer {
  Goalscorer({
    required this.time,
    required this.homeScorer,
    required this.homeScorerId,
    required this.homeAssist,
    required this.homeAssistId,
    required this.score,
    required this.awayScorer,
    required this.awayScorerId,
    required this.awayAssist,
    required this.awayAssistId,
    required this.info,
    required this.scoreInfoTime,
  });

  late String time;
  late String homeScorer;
  late String homeScorerId;
  late String homeAssist;
  late String homeAssistId;
  late String score;
  late String awayScorer;
  late String awayScorerId;
  late String awayAssist;
  late String awayAssistId;
  late String info;
  late String scoreInfoTime;

  Goalscorer.fromJson(dynamic json) {
    time = json['time'];
    homeScorer = json['home_scorer'];
    homeScorerId = json['home_scorer_id'];
    homeAssist = json['home_assist'];
    homeAssistId = json['home_assist_id'];
    score = json['score'];
    awayScorer = json['away_scorer'];
    awayScorerId = json['away_scorer_id'];
    awayAssist = json['away_assist'];
    awayAssistId = json['away_assist_id'];
    info = json['info'];
    scoreInfoTime = json['score_info_time'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['home_scorer'] = homeScorer;
    map['home_scorer_id'] = homeScorerId;
    map['home_assist'] = homeAssist;
    map['home_assist_id'] = homeAssistId;
    map['score'] = score;
    map['away_scorer'] = awayScorer;
    map['away_scorer_id'] = awayScorerId;
    map['away_assist'] = awayAssist;
    map['away_assist_id'] = awayAssistId;
    map['info'] = info;
    map['score_info_time'] = scoreInfoTime;
    return map;
  }
}
