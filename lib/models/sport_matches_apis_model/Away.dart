import 'StartingLineups.dart';
import 'Substitutes.dart';
import 'Coach.dart';

class Away {
  Away({
    required this.startingLineups, required
      this.substitutes, required
      this.coach, });
 late List<StartingLineups> startingLineups;
  late List<Substitutes> substitutes;
  late List<Coach> coach;
  Away.fromJson(dynamic json)   {
    if (json['starting_lineups'] != null) {
      startingLineups = [];
      json['starting_lineups'].forEach((v) {
        startingLineups.add(StartingLineups.fromJson(v));
      });
    }
    if (json['substitutes'] != null) {
      substitutes = [];
      json['substitutes'].forEach((v) {
        substitutes.add(Substitutes.fromJson(v));
      });
    }
    if (json['coach'] != null) {
      coach = [];
      json['coach'].forEach((v) {
        coach.add(Coach.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (startingLineups != null) {
      map['starting_lineups'] = startingLineups.map((v) => v.toJson()).toList();
    }
    if (substitutes != null) {
      map['substitutes'] = substitutes.map((v) => v.toJson()).toList();
    }
    if (coach != null) {
      map['coach'] = coach.map((v) => v.toJson()).toList();
    }
    return map;
  }

}