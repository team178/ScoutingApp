import 'package:scoutingapp/common/models.dart';
import 'package:scoutingapp/server/mongo.dart';
import 'package:shelf_plus/shelf_plus.dart';

void main() async => await shelfRun(init);

Future<Handler> init() async {
  var app = Router().plus;

  var db = Mongo();
  await db.init();

  app.post('/sync', (Request request) async {
    var teams = await db.getAllTeams();
    var matches = await db.getAllMatches();

    var data = await request.body.asJson;
    List<ScoutData> datas = List<ScoutData>.from(data
        .map((item) => ScoutData.fromJson(item))
        .toList());

    await db.insertDatas(datas);

    return {"matches": matches, "teams": teams};
  });

  return app;
}
