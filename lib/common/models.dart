import 'package:scoutingapp/common/utils.dart';

/// Represents an FRC team
class Team with MapSerializeable {
  final int number;
  final String name;
  final Object robot;

  Team({required this.number, required this.name, required this.robot});
}

/// Basic information about an FRC match
class Match with MapSerializeable {
  final int number;
  final String key;
  late final List<int> redAlliance;
  late final List<int> blueAlliance;

  Match(
      {required this.number,
      required this.key,
      required redAlliance,
      required blueAlliance}) {
    this.redAlliance = List<int>.from(redAlliance);
    this.blueAlliance = List<int>.from(blueAlliance);
  }
}

/// Data created by the scouting app about a Team in a Match
class ScoutData with MapSerializeable {
  final String matchKey;
  final int teamNumber;
  final Object data;

  ScoutData(
      {required this.matchKey, required this.teamNumber, required this.data});
}
