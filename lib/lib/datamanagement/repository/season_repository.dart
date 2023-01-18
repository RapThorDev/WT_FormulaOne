import 'dart:convert';
import 'dart:developer';
import 'package:f1_application/lib/datamanagement/error_handler.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';

class SeasonRepository {
  SeasonRepository();

  final ErgastApiClient clientErgast = ErgastApiClient();

  final ErrorHandler _errorHandler = ErrorHandler();

  Future<List<Season>> fetchSeasons() async {
    List<Season> seasons = [];
    try {
      final response = await clientErgast.get(type: GetType.season);
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonObject = jsonDecode(response.body);
          seasons = Season.listFromJson(
              jsonObject["MRData"]["SeasonTable"]["Seasons"]);
          break;
        default:
          throw _errorHandler.getErrorResponse(response);
      }
    } catch (e) {
      log(e.toString());
    }
    return seasons;
  }
}
