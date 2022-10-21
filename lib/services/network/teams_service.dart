import 'dart:convert';

import 'package:credits_tracker_flutter_app/errors/networ_error.dart';
import 'package:credits_tracker_flutter_app/services/network/dto/teams_response.dart';

import 'package:http/http.dart' as http;

class TeamsService {
  final String baseUrl;
  final String _endpoint = "10s/prod/v1/2022/teams.json";

  TeamsService({required this.baseUrl});

  Future<List<TeamsDTO>> teams() async {
    final response = await http.get(Uri.https(baseUrl, _endpoint));

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }

    final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;

    return TeamsResponse.fromJson(decodedResponse).league.teams;
  }
}
