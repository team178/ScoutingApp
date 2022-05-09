/// Represents an FRC team
class Team {
  final int number;
  final String name;
  final Object robot;

  Team({required this.number, required this.name, required this.robot});

  Team.fromJson(Map<String, dynamic> data)
      : number = data['number'],
        name = data['name'],
        robot = data['robot'];

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'robot': robot
    };
  }
}

/// Basic information about an FRC match
class Match {
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

  Match.fromJson(Map<String, dynamic> data)
      : number = data['number'],
        key = data['key'],
        redAlliance = List<int>.from(data['redAlliance']),
        blueAlliance = List<int>.from(data['blueAlliance']);

  Map<String, dynamic> toJson() {
    return {
      'number': number,
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

  ScoutData.fromJson(Map<String, dynamic> data)
      : matchKey = data['matchKey'],
        teamNumber = data['teamNumber'],
        data = data['data'];

  Map<String, dynamic> toJson() {
    return {
      'matchKey': matchKey,
      'teamNumber': teamNumber,
      'data': data
    };
  }
}
