/// Represents an FRC team
class Team {
  final int number;
  final String name;
  final Object robot;

  Team({required this.number, required this.name, required this.robot});

  static Team fromJson(item) {
    return Team(
        number: item['number'], name: item['name'], robot: item['robot']);
  }

  Map<String, dynamic> toJson() {
    return {'number': number, 'name': name, 'robot': robot};
  }
}

/// Basic information about an FRC match
class Match {
  final int number;
  final String key;
  final List<int> redAlliance;
  final List<int> blueAlliance;

  Match(
      {required this.number,
      required this.key,
      required this.redAlliance,
      required this.blueAlliance});

  static Match fromJson(item) {
    return Match(
        number: item['match_number'],
        key: item['key'],
        redAlliance: List<int>.from(item['redAlliance']),
        blueAlliance: List<int>.from(item['blueAlliance']));
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
  final String matchKey;
  final int teamNumber;
  final Object data;

  ScoutData(
      {required this.matchKey, required this.teamNumber, required this.data});

  static ScoutData fromJson(item) {
    return ScoutData(
        matchKey: item['match_key'],
        teamNumber: item['team_number'],
        data: item['data']);
  }

  Map<String, dynamic> toJson() {
    return {'match_key': matchKey, 'team_number': teamNumber, 'data': data};
  }
}
