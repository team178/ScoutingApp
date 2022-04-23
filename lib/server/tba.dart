import 'dart:convert';
import 'dart:io';

import 'models.dart';

/// Interface for retrieving data from The Blue Alliance API.
///
/// https://www.thebluealliance.com/apidocs/v3
///
/// Requres an auth token to be passed in the constructor, which can retrieved
/// from the account page on TBA
/// https://www.thebluealliance.com/account
class TBA {
  final HttpClient _httpClient = HttpClient();
  final String authToken;

  TBA({required this.authToken});

  Future<dynamic> _get(String uri) async {
    var request = await _httpClient
        .getUrl(Uri.parse('https://www.thebluealliance.com/api/v3/$uri'));
    request.headers.add('X-TBA-Auth-Key', authToken);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    return jsonDecode(responseBody);
  }

  /// Retrieves a list of all teams from an event using it's event key
  /// Event key can be found in the URL of the event page on TBA
  Future<List<Team>> getTeamsFromEvent(String eventKey) async {
    List<dynamic> json = await _get('event/$eventKey/teams/simple');
    List<Team> teams = json.map((dynamic item) => Team.fromJson(item)).toList();

    return teams;
  }

  /// Retrieves a list of all qualification matches from an event using it's event key
  /// Event key can be found in the URL of the event page on TBA
  Future<List<Match>> getMatchesFromEvent(String eventKey) async {
    List<dynamic> json = await _get('event/$eventKey/matches/simple');
    List<Match> matches = json
        .where((dynamic item) => item['comp_level'] == 'qm')
        .map((dynamic item) => Match.fromJson(item))
        .toList();

    return matches;
  }

  /// Closes the HTTP client
  void close() {
    _httpClient.close();
  }
}
