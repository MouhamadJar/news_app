class Substitutes {
  Substitutes({
    required  this.lineupPlayer,
    required   this.lineupNumber,
    required  this.lineupPosition,
    required this.playerKey,});

  Substitutes.fromJson(dynamic json) {
    lineupPlayer = json['lineup_player'];
    lineupNumber = json['lineup_number'];
    lineupPosition = json['lineup_position'];
    playerKey = json['player_key'];
  }
  late String lineupPlayer;
  late String lineupNumber;
  late  String lineupPosition;
  late String playerKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lineup_player'] = lineupPlayer;
    map['lineup_number'] = lineupNumber;
    map['lineup_position'] = lineupPosition;
    map['player_key'] = playerKey;
    return map;
  }

}