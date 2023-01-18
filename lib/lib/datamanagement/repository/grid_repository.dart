import 'dart:convert';
import 'dart:developer';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';
import 'package:http/http.dart';
import 'package:f1_application/lib/datamanagement/error_handler.dart';

class GridRepository {
  GridRepository();

  final ErgastApiClient clientErgast = ErgastApiClient();

  final ErrorHandler _errorHandler = ErrorHandler();

  Future<List<Driver>> fetchGrid(int  seasonYear) async {
    List<Driver> drivers = [];
    try {
      Response response = await clientErgast.get(type: GetType.grid, year: seasonYear);
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonObject = jsonDecode(response.body);
          drivers = Driver.listFromJson(jsonObject["MRData"]["DriverTable"]["Drivers"]);
          break;
        default:
          throw _errorHandler.getErrorResponse(response);
      }
    } catch (e) {
      log(e.toString());
    }

    return drivers;
  }
}
