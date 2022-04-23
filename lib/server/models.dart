/// Represents an FRC team
class Team {
  final int number;
  final String name;
  final Object robot;

  Team({required this.number, required this.name, required this.robot});

  static Team fromJson(item) {
    return Team(number: item['team_number'], name: item['nickname'], robot: {});
  }

  Map<String, dynamic> toJson() {
    return {'number': number, 'name': name, 'robot': robot};
  }
}

/// Basic information about an FRC match
class Match {
  final int number;
  final String key;
  final List<String> redAlliance;
  final List<String> blueAlliance;

  Match(
      {required this.number,
      required this.key,
      required this.redAlliance,
      required this.blueAlliance});

  static Match fromJson(item) {
    return Match(
        number: item['match_number'],
        key: item['key'],
        redAlliance: List<String>.from(item['alliances']['red']['team_keys']),
        blueAlliance:
            List<String>.from(item['alliances']['blue']['team_keys']));
  }

  Map<String, dynamic> toJson() {
    return {
      'match_number': number,
      'key': key,
      'redAlliance': redAlliance,
      'blueAlliance': blueAlliance
    };
  }
}

/// Data created by the scouting app about a Team in a Match
class ScoutData {
  final int matchNumber;
  final int teamNumber;
  final Object data;

  ScoutData(
      {required this.matchNumber,
      required this.teamNumber,
      required this.data});
}
