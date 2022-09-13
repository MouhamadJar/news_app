import 'Goalscorer.dart';
import 'Cards.dart';
import 'Substitutions.dart';
import 'Lineup.dart';
import 'Statistics.dart';
import 'Statistics1half.dart';

class MatchModel {
  MatchModel({
    required this.matchId,
    required this.countryId,
    required this.countryName,
    required this.leagueId,
    required this.leagueName,
    required this.matchDate,
    required this.matchStatus,
    required this.matchTime,
    required this.matchHometeamId,
    required this.matchHometeamName,
    required this.matchHometeamScore,
    required this.matchAwayteamName,
    required this.matchAwayteamId,
    required this.matchAwayteamScore,
    required this.matchHometeamHalftimeScore,
    required this.matchAwayteamHalftimeScore,
    required this.matchHometeamExtraScore,
    required this.matchAwayteamExtraScore,
    required this.matchHometeamPenaltyScore,
    required this.matchAwayteamPenaltyScore,
    required this.matchHometeamFtScore,
    required this.matchAwayteamFtScore,
    required this.matchHometeamSystem,
    required this.matchAwayteamSystem,
    required this.matchLive,
    required this.matchRound,
    required this.matchStadium,
    required this.matchReferee,
    required this.teamHomeBadge,
    required this.teamAwayBadge,
    required this.leagueLogo,
    required this.countryLogo,
    required this.leagueYear,
    required this.fkStageKey,
    required this.stageName,
    required this.goalscorer,
    required this.cards,
    required this.substitutions,
    required this.lineup,
    required this.statistics,
    required this.statistics1half,
  });

  late String matchId;
  late String countryId;
  late String countryName;
  late String leagueId;
  late String leagueName;
  late String matchDate;
  late String matchStatus;
  late String matchTime;
  late String matchHometeamId;
  late String matchHometeamName;
  late String matchHometeamScore;
  late String matchAwayteamName;
  late String matchAwayteamId;
  late String matchAwayteamScore;
  late String matchHometeamHalftimeScore;
  late String matchAwayteamHalftimeScore;
  late String matchHometeamExtraScore;
  late String matchAwayteamExtraScore;
  late String matchHometeamPenaltyScore;
  late String matchAwayteamPenaltyScore;
  late String matchHometeamFtScore;
  late String matchAwayteamFtScore;
  late String matchHometeamSystem;
  late String matchAwayteamSystem;
  late String matchLive;
  late String matchRound;
  late String matchStadium;
  late String matchReferee;
  late String teamHomeBadge;
  late String teamAwayBadge;
  late String leagueLogo;
  late String countryLogo;
  late String leagueYear;
  late String fkStageKey;
  late String stageName;
  late List<Goalscorer> goalscorer;
  late List<Cards> cards;
  late Substitutions substitutions;
  late Lineup lineup;
  late List<Statistics> statistics;
  late List<Statistics1half> statistics1half;

  MatchModel.fromJson(dynamic json) {
    matchId = json['match_id'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    leagueId = json['league_id'];
    leagueName = json['league_name'];
    matchDate = json['match_date'];
    matchStatus = json['match_status'];
    matchTime = json['match_time'];
    matchHometeamId = json['match_hometeam_id'];
    matchHometeamName = json['match_hometeam_name'];
    matchHometeamScore = json['match_hometeam_score'];
    matchAwayteamName = json['match_awayteam_name'];
    matchAwayteamId = json['match_awayteam_id'];
    matchAwayteamScore = json['match_awayteam_score'];
    matchHometeamHalftimeScore = json['match_hometeam_halftime_score'];
    matchAwayteamHalftimeScore = json['match_awayteam_halftime_score'];
    matchHometeamExtraScore = json['match_hometeam_extra_score'];
    matchAwayteamExtraScore = json['match_awayteam_extra_score'];
    matchHometeamPenaltyScore = json['match_hometeam_penalty_score'];
    matchAwayteamPenaltyScore = json['match_awayteam_penalty_score'];
    matchHometeamFtScore = json['match_hometeam_ft_score'];
    matchAwayteamFtScore = json['match_awayteam_ft_score'];
    matchHometeamSystem = json['match_hometeam_system'];
    matchAwayteamSystem = json['match_awayteam_system'];
    matchLive = json['match_live'];
    matchRound = json['match_round'];
    matchStadium = json['match_stadium'];
    matchReferee = json['match_referee'];
    teamHomeBadge = json['team_home_badge'];
    teamAwayBadge = json['team_away_badge'];
    leagueLogo = json['league_logo'];
    countryLogo = json['country_logo'];
    leagueYear = json['league_year'];
    fkStageKey = json['fk_stage_key'];
    stageName = json['stage_name'];
    if (json['goalscorer'] != null) {
      goalscorer = [];
      json['goalscorer'].forEach((v) {
        goalscorer.add(Goalscorer.fromJson(v));
      });
    }
    if (json['cards'] != null) {
      cards = [];
      json['cards'].forEach((v) {
        cards.add(Cards.fromJson(v));
      });
    }
    substitutions = (json['substitutions'] != null
        ? Substitutions.fromJson(json['substitutions'])
        : null)!;
    lineup = (json['lineup'] != null ? Lineup.fromJson(json['lineup']) : null)!;
    if (json['statistics'] != null) {
      statistics = [];
      json['statistics'].forEach((v) {
        statistics.add(Statistics.fromJson(v));
      });
    }
    if (json['statistics_1half'] != null) {
      statistics1half = [];
      json['statistics_1half'].forEach((v) {
        statistics1half.add(Statistics1half.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['match_id'] = matchId;
    map['country_id'] = countryId;
    map['country_name'] = countryName;
    map['league_id'] = leagueId;
    map['league_name'] = leagueName;
    map['match_date'] = matchDate;
    map['match_status'] = matchStatus;
    map['match_time'] = matchTime;
    map['match_hometeam_id'] = matchHometeamId;
    map['match_hometeam_name'] = matchHometeamName;
    map['match_hometeam_score'] = matchHometeamScore;
    map['match_awayteam_name'] = matchAwayteamName;
    map['match_awayteam_id'] = matchAwayteamId;
    map['match_awayteam_score'] = matchAwayteamScore;
    map['match_hometeam_halftime_score'] = matchHometeamHalftimeScore;
    map['match_awayteam_halftime_score'] = matchAwayteamHalftimeScore;
    map['match_hometeam_extra_score'] = matchHometeamExtraScore;
    map['match_awayteam_extra_score'] = matchAwayteamExtraScore;
    map['match_hometeam_penalty_score'] = matchHometeamPenaltyScore;
    map['match_awayteam_penalty_score'] = matchAwayteamPenaltyScore;
    map['match_hometeam_ft_score'] = matchHometeamFtScore;
    map['match_awayteam_ft_score'] = matchAwayteamFtScore;
    map['match_hometeam_system'] = matchHometeamSystem;
    map['match_awayteam_system'] = matchAwayteamSystem;
    map['match_live'] = matchLive;
    map['match_round'] = matchRound;
    map['match_stadium'] = matchStadium;
    map['match_referee'] = matchReferee;
    map['team_home_badge'] = teamHomeBadge;
    map['team_away_badge'] = teamAwayBadge;
    map['league_logo'] = leagueLogo;
    map['country_logo'] = countryLogo;
    map['league_year'] = leagueYear;
    map['fk_stage_key'] = fkStageKey;
    map['stage_name'] = stageName;
    if (goalscorer != null) {
      map['goalscorer'] = goalscorer.map((v) => v.toJson()).toList();
    }
    if (cards != null) {
      map['cards'] = cards.map((v) => v.toJson()).toList();
    }
    if (substitutions != null) {
      map['substitutions'] = substitutions.toJson();
    }
    if (lineup != null) {
      map['lineup'] = lineup.toJson();
    }
    if (statistics != null) {
      map['statistics'] = statistics.map((v) => v.toJson()).toList();
    }
    if (statistics1half != null) {
      map['statistics_1half'] = statistics1half.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
