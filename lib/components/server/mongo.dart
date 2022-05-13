import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

import 'package:scoutingapp/components/common/form.dart';
import 'package:scoutingapp/components/common/models.dart';

class Mongo {
  late final Db _db;

  late final DbCollection _teamCol;
  late final DbCollection _matchCol;
  late final DbCollection _dataCol;
  late final DbCollection _formsCol;

  Mongo(String uri) {
    _db = Db(uri);
  }

  factory Mongo.from(String host, int port) {
    return Mongo('mongodb://$host:$port/scouting');
  }

  Future<void> init() async {
    await _db.open();

    _teamCol = _db.collection('teams');
    _teamCol.createIndex(key: "number", unique: true);

    _matchCol = _db.collection('matches');
    _matchCol.createIndex(key: "key", unique: true);

    _dataCol = _db.collection('data');

    _formsCol = _db.collection('forms');
    _formsCol.createIndex(key: "name", unique: true);
  }

  Future<void> insertTeams(List<Team> teams) async {
    await _teamCol.insertMany(teams.map((team) => team.toJson()).toList());
  }

  Future<void> insertMatches(List<Match> matches) async {
    await _matchCol.insertMany(matches.map((match) => match.toJson()).toList());
  }

  Future<void> insertDatas(List<ScoutData> datas) async {
    await _dataCol.insertMany(datas.map((data) => data.toJson()).toList());
  }

  Future<void> insertForm(ScoutForm form) async {
    await insertForms([form]);
  }

  Future<void> insertForms(List<ScoutForm> forms) async {
    await _formsCol.insertMany(forms.map((form) => form.toJson()).toList());
  }

  Future<Team?> getTeam(int number) async {
    var teams = await getTeams({'number': number});
    if (teams.isEmpty) {
      return null;
    }
    return teams.first;
  }

  Future<List<Team>> getTeams(Map<String, dynamic> query) async {
    var teams = _teamCol.aggregateToStream([
      {
        "\$project": {"_id": 0}
      },
      {"\$match": query}
    ]);
    return teams.map((team) => Team.fromJson(team)).toList();
  }

  Future<Match?> getMatchByNumber(int number) async {
    var matches = await getMatches({'number': number});
    if (matches.isEmpty) {
      return null;
    }
    return matches.first;
  }

  Future<Match?> getMatchByID(String id) async {
    var matches = await getMatches({'key': id});
    if (matches.isEmpty) {
      return null;
    }
    return matches.first;
  }

  Future<List<Match>> getMatches(Map<String, dynamic> query) async {
    var matches = _matchCol.aggregateToStream([
      {
        "\$project": {"_id": 0}
      },
      {"\$match": query},
      {
        "\$sort": {"number": 1}
      }
    ]);
    return matches.map((match) => Match.fromJson(match)).toList();
  }

  Future<List<ScoutData>> getDatas(Map<String, dynamic> query) async {
    var datas = _dataCol.aggregateToStream([
      {
        "\$project": {"_id": 0}
      },
      {"\$match": query}
    ]);
    return datas.map((data) => ScoutData.fromJson(data)).toList();
  }

  Future<ScoutForm> getForm(String name) async {
    var form = await _formsCol.aggregateToStream([
      {
        "\$project": {"_id": 0}
      },
      {
        "\$match": {"name": name}
      }
    ]).first;
    return ScoutForm.fromJson(form);
  }
}
