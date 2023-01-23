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
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonObject = jsonDecode(response.body);
          return Season.listFromJson(jsonObject["MRData"]["SeasonTable"]["Seasons"]);
        default:
          throw _errorHandler.getErrorResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }
}
