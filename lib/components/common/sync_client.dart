import 'dart:convert';
import 'dart:io';

import 'package:scoutingapp/components/common/form.dart';
import 'package:scoutingapp/components/common/models.dart';

class SyncClientData {
  final List<Match> matches;
  final List<Team> teams;
  final ScoutForm? form;

  SyncClientData(this.matches, this.teams, this.form);
}

/// HTTP client for calling the scouting app API sync endpoint.
/// Example:
/// ```
/// SyncClient client = SyncClient('localhost', '8080');
/// SyncClientData data = await client.sync();
/// ```
class SyncClient {
  final String host;
  final int port;
  late final HttpClient _client;

  SyncClient(this.host, this.port) {
    _client = HttpClient();
  }

  Future<SyncClientData> sync(List<ScoutData> datas) async {
    HttpClientRequest req = await _client.post(host, port, '/sync');
    req.headers.contentType = ContentType.json;
    req.write(jsonEncode(datas.map((e) => e.toJson()).toList()));

    HttpClientResponse res = await req.close();

    String body = await res.transform(utf8.decoder).join();
    Map<String, dynamic> data = jsonDecode(body);

    List<Match> matches =
        List<Match>.from(data['matches'].map((e) => Match.fromJson(e)));
    List<Team> teams =
        List<Team>.from(data['teams'].map((e) => Team.fromJson(e)));
    ScoutForm? form =
        data['form'] == null ? null : ScoutForm.fromJson(data['form']);

    return SyncClientData(matches, teams, form);
  }
}
