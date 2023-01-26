import 'dart:convert';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';
import 'package:f1_application/lib/network/request/request_handler.dart';
import 'package:http/http.dart';

class SeasonRepository {
  SeasonRepository();

  final ErgastApiClient clientErgast = ErgastApiClient();
  final RequestHandler _handler = RequestHandler();

  Future<List<Season>> fetchSeasons() async {
    return await _handler.handleFetchSeason(() async {
      Response response = await clientErgast.get(type: GetType.season).timeout(const Duration(seconds: 10));
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      return Season.listFromJson(jsonObject["MRData"]["SeasonTable"]["Seasons"]);
    });
  }
}
