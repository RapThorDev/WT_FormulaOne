import 'dart:convert';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';
import 'package:f1_application/lib/network/request/request_handler.dart';
import 'package:http/http.dart';

class GridRepository {
  GridRepository();

  final ErgastApiClient clientErgast = ErgastApiClient();
  final RequestHandler _handler = RequestHandler();

  Future<List<Driver>> fetchGrid(int  seasonYear) async {
    return await _handler.handle(() async {
      Response response = await clientErgast.get(type: GetType.grid, year: seasonYear).timeout(const Duration(seconds: 10));
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      return Driver.listFromJson(jsonObject["MRData"]["DriverTable"]["Drivers"]);
    });
  }
}
