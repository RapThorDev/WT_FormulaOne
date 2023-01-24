import 'dart:convert';
import 'package:f1_application/lib/datamanagement/error_handler.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';

class SeasonRepository {
  SeasonRepository();

  final ErgastApiClient clientErgast = ErgastApiClient();

  final ErrorHandler _errorHandler = ErrorHandler();

  Future<List<Season>> fetchSeasons() async {
    try {
      final response = await clientErgast.get(type: GetType.season);
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      return Season.listFromJson(jsonObject["MRData"]["SeasonTable"]["Seasons"]);
    } catch (e) {
      throw _errorHandler.handle(e);
    }
  }
}
