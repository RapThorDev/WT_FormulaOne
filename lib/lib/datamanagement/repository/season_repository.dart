import 'dart:convert';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';

class SeasonRepository {
  SeasonRepository();

  final ErgastApiClient clientErgast = ErgastApiClient();

  Future<List<Season>> fetchSeasons() async {
    List<Season> seasons = [];
    final response = await clientErgast.get(type: GetType.season);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      seasons = Season.listFromJson(
          jsonObject["MRData"]["SeasonTable"]["Seasons"]);
    }
    return seasons;
  }
}
