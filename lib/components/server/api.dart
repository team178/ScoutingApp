import 'dart:convert';
import 'dart:io';

import 'package:scoutingapp/components/server/config.dart';
import 'package:shelf_plus/shelf_plus.dart';

import 'package:scoutingapp/components/server/mongo.dart';
import 'package:scoutingapp/components/common/models.dart';
import 'package:scoutingapp/components/common/form.dart';

/// Scouting App API
/// OpenAPI specification can be found in `api.yaml`,
/// which can be put into editor.swagger.io or similar software to
/// see documentation.
class API {
  static late Mongo db;

  /// Iniitialize MongoDB connection
  static Future<void> initMongo() async {
    if (ServerConfig.monogoURI != null) {
      db = Mongo(ServerConfig.monogoURI.toString());
      await db.init();
      stdout.writeln("Connected to MongoDB at ${ServerConfig.monogoURI}");
    } else {
      db = Mongo.from(ServerConfig.mongoHost, ServerConfig.mongoPort);
      await db.init();
      stdout.writeln(
          "Connected to MongoDB at ${ServerConfig.mongoHost}:${ServerConfig.mongoPort}");
    }
  }

  static Future<Handler> init() async {
    var app = Router().plus;

    /// Sync
    app.post('/sync', (Request request) async {
      List<ScoutData> datas;
      try {
        var data = await request.body.asJson;
        datas = List<ScoutData>.from(
            data.map((item) => ScoutData.fromJson(item)).toList());
      } on TypeError catch (e) {
        return Response.badRequest(body: 'Bad Request: ${e.toString()}');
      }

      if (datas.isNotEmpty) {
        await db.insertDatas(datas);
      }

      var teams = await db.getTeams({});
      var matches = await db.getMatches({});

      ScoutForm? form;
      if (ServerConfig.currentForm != null) {
        form = await db.getForm(ServerConfig.currentForm!);
      }

      return Response(202,
          body: jsonEncode({"matches": matches, "teams": teams, "form": form}),
          headers: {'Content-Type': 'application/json'});
    });

    /// Query scout Data
    app.post('/query', (Request request) async {
      var params = request.url.queryParameters;

      Map<String, dynamic> query = {};

      if (params.containsKey('team')) {
        query['teamNumber'] = int.tryParse(params['team'].toString());
      }

      if (params.containsKey('match')) {
        query['match'] = int.tryParse(params['match'].toString());
      }

      if (params.containsKey('match_id')) {
        query['matchKey'] = params['match_id'].toString();
      }

      Map<String, dynamic> body = await request.body.asJson;
      body.forEach((key, value) {
        query['data.$key'] = value;
      });

      if (query.containsValue(null)) {
        return Response.badRequest(
            body: "Bad request: Query cannot contain incorrect or null types");
      }

      var datas = await db.getDatas(query);

      return datas;
    });

    // Get all teams
    app.get('/teams/all', (Request request) async {
      var teams = await db.getTeams({});
      return teams.map((e) => e.toJson()).toList();
    });

    /// Get team by number
    app.get('/teams/<number>', (Request request, String number) async {
      var teamNum = int.tryParse(number);
      if (teamNum == null) {
        return Response.badRequest(
            body: "Bad request: Team number must be an integer");
      }
      var team = await db.getTeam(teamNum);
      if (team == null) {
        return Response.notFound("Team not found");
      }
      return team.toJson();
    });

    /// Create Team
    app.post('/teams/create', (Request request) async {
      Team team;
      try {
        team = Team.fromJson(await request.body.asJson);
      } on TypeError catch (e) {
        return Response.badRequest(body: "Bad request: ${e.toString()}");
      }
      await db.insertTeams([team]);
      return Response(201);
    });

    /// Get matches
    app.get('/matches', (Request request) async {
      var params = request.url.queryParameters;

      Map<String, dynamic> query = {};

      if (params.containsKey('from')) {
        if (query['number'] == null) {
          query['number'] = {};
        }
        query['number']["\$gte"] = int.tryParse(params['from'].toString());
      }

      if (params.containsKey('to')) {
        if (query['number'] == null) {
          query['number'] = {};
        }
        query['number']["\$lte"] = int.tryParse(params['to'].toString());
      }

      if (params.containsKey('team')) {
        var team = int.tryParse(params['team'].toString());
        if (team != null) {
          query['\$or'] = [
            {"redAlliance": team},
            {"blueAlliance": team}
          ];
        }
      }

      var matches = await db.getMatches(query);
      return matches.map((e) => e.toJson()).toList();
    });

    /// Get match by id
    app.get('/matches/id/<id>', (Request request, String id) async {
      var match = await db.getMatchByID(id);
      if (match == null) {
        return Response.notFound("Match not found");
      }
      return match.toJson();
    });

    /// Get match by number
    app.get('/matches/num/<number>', (Request request, String number) async {
      var matchNumber = int.tryParse(number);
      if (matchNumber == null) {
        return Response.badRequest(
            body: "Bad request: Match number must be an integer");
      }
      var match = await db.getMatchByNumber(matchNumber);
      if (match == null) {
        return Response.notFound("Match not found");
      }
      return match.toJson();
    });

    /// Create match
    app.post('/matches/create', (Request request) async {
      Match match;
      try {
        match = Match.fromJson(await request.body.asJson);
      } on TypeError catch (e) {
        return Response.badRequest(body: "Bad request: ${e.toString()}");
      }
      await db.insertMatches([match]);
      return Response(201);
    });

    /// Get all forms
    app.get('/forms', (Request request) async {
      var forms = await db.getAllForms();
      return forms.map((e) => e.toJson()).toList();
    });

    /// Get form by id
    app.get('/forms/id/<id>', (Request request, String id) async {
      var form = await db.getForm(id);
      if (form == null) {
        return Response.notFound("Form not found");
      }
      return form.toJson();
    });

    /// Replace form
    app.put('/forms/id/<id>', (Request request, String id) async {
      ScoutForm form;
      try {
        form = ScoutForm.fromJson(await request.body.asJson);
      } on TypeError catch (e) {
        return Response.badRequest(body: "Bad request: ${e.toString()}");
      }
      if (await db.updateForm(form, id)) {
        return Response(200);
      } else {
        return Response.notFound("Form not found");
      }
    });

    /// Create form
    app.post('/forms/create', (Request request) async {
      ScoutForm form;
      try {
        var json = await request.body.asJson;
        form = ScoutForm.fromJson(json);
      } on TypeError catch (e) {
        return Response.badRequest(body: "Bad request: ${e.toString()}");
      }
      await db.insertForm(form);
      return Response(201);
    });

    /// Get current active Form
    app.get('/forms/current', (Request request) async {
      var id = ServerConfig.currentForm;
      if (id != null) {
        var form = await db.getForm(id);
        if (form == null) {
          return Response(204);
        }
        return form.toJson();
      }
      return Response(204);
    });

    /// Set current active Form
    app.put('/forms/current', (Request request) async {
      var body = await request.body.asJson;
      var id = body['id'];
      if (id == null) {
        return Response.badRequest(
            body: "Bad request: Must have valid 'id' field");
      }

      if (await db.getForm(id) == null) {
        return Response.badRequest(body: "Form with id '$id' not found");
      }

      ServerConfig.currentForm = id;
      ServerConfig.save();

      return Response(200);
    });

    /// HTCPCP
    app.get('/brewCoffee', (Request request) async {
      return Response(418,
          headers: {'Content-Type': 'text/html'},
          body:
              '<script>(()=>{for(j=function(){for(h=\'#7aAr<)1y6dBjK}>?Vp\',a=new Array(h.length),l=0;l<h.length;l++)a[l]=h.charCodeAt(l);return a}(),m=m=>document.write(m),k=decodeURI("".concat("%3Ctahirah;%3CnsHeI4oe%3Ced1Hnb%3Eh%20;CyIrpehysa%20ab%201r%3Eedar%3Eorl%20g%20ihip%3C/,ao%20%20Wtan%3Ee%20vdro%20%3E%20%20/e%3CTmur%3C%3EdT%20%3Ee8ainetao\'u1mpi;%20%20hhp%20tshlttI%3C2rtorrrPrtui%20i%20ct,!%3Cr2h/:/%20urbfbp%203etfpa%3E%3Ch.2mrrdbt%3E%20ranet//%3C.2ebc%3Egss/tctsl%20FP2rbo%3CtuR9eo%20al%20aeaee%3Cg%3El%3Cl%3Ceo4sgmuthum%20ptum=%20hthr%3Ei%20bMekImibg%20/ec,ai%3C%20mastogeh%20e,w%20Yehrst%3C%3Elbdh%3Efcf%3Es%3E%20%3C4rteathta.as%203d%202%20=ftecoied%3C/o%20%20%3Cbs%20krmapr2%3E,Cu%20rAy/soem/%20:e:\'ot%20es%3Eanat%3Ci/%3E%20C%20%3EPnebdd%3E%20a%3Ct/rhtgmsr%20)")).split(""),g=k.length%j.length,l=k.length-1;l>=0;l--)g--,-1==g&&(g=j.length-1),f=l+j[g],f>=k.length||(c=k[l],b=k[f],k[f]=c,k[l]=b);for(n=m,i="",l=0;l<k.length;l++)i+=k[l];n(i)})();</script>');
    });

    return app;
  }
}
