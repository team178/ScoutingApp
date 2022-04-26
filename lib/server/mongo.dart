import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

import '../common/models.dart';

class Mongo {
  late final Db _db;

  late final DbCollection _teamCol;
  late final DbCollection _matchCol;
  late final DbCollection _dataCol;

  Mongo() {
    _db = Db('mongodb://localhost:27017/scouting');
  }

  Future<void> init() async {
    await _db.open();

    _teamCol = _db.collection('teams');
    _teamCol.createIndex(key: "number", unique: true);
    _matchCol = _db.collection('matches');
    _matchCol.createIndex(key: "key", unique: true);
    _dataCol = _db.collection('data');
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

  Future<List<Team>> getAllTeams() async {
    var teams = _teamCol.find();
    return teams.map((team) => Team.fromJson(team)).toList();
  }

  Future<List<Match>> getAllMatches() async {
    var matches = _matchCol.find();
    return matches.map((match) => Match.fromJson(match)).toList();
  }

  Future<List<ScoutData>> getAllDatas() async {
    var datas = _dataCol.find();
    return datas.map((data) => ScoutData.fromJson(data)).toList();
  }
}
