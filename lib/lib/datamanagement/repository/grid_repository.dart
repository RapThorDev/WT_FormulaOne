import 'dart:convert';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';
import 'package:http/http.dart';
import 'package:f1_application/lib/datamanagement/error_handler.dart';

class GridRepository {
  GridRepository();

  final ErgastApiClient clientErgast = ErgastApiClient();

  final ErrorHandler _errorHandler = ErrorHandler();

  Future<List<Driver>> fetchGrid(int  seasonYear) async {
    try {
      Response response = await clientErgast.get(type: GetType.grid, year: seasonYear).timeout(const Duration(seconds: 10));
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      return Driver.listFromJson(jsonObject["MRData"]["DriverTable"]["Drivers"]);
    } catch (e) {
      throw _errorHandler.handle(e);
    }
  }
}
