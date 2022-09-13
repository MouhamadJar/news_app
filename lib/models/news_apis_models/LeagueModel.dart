class LeagueModel {
  LeagueModel({
     required this.countryId,
    required this.countryName,
    required this.leagueId,
    required this.leagueName,
    required this.leagueSeason,
    required this.leagueLogo,
    required this.countryLogo,});

 late String countryId;
  late String countryName;
  late  String leagueId;
  late String leagueName;
  late String leagueSeason;
  late String leagueLogo;
  late String countryLogo;

  LeagueModel.fromJson(dynamic json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
    leagueId = json['league_id'];
    leagueName = json['league_name'];
    leagueSeason = json['league_season'];
    leagueLogo = json['league_logo'];
    countryLogo = json['country_logo'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_id'] = countryId;
    map['country_name'] = countryName;
    map['league_id'] = leagueId;
    map['league_name'] = leagueName;
    map['league_season'] = leagueSeason;
    map['league_logo'] = leagueLogo;
    map['country_logo'] = countryLogo;
    return map;
  }

}