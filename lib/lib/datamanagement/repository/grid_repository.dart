import 'dart:convert';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';

class GridRepository {
  GridRepository();

  final ErgastApiClient clientErgast = ErgastApiClient();

  Future<Map<String, dynamic>> fetchGrid(int  seasonYear) async {
    try {
      final response = await clientErgast.get(type: GetType.grid, year: seasonYear);
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonObject = jsonDecode(response.body);
          List<Driver> drivers = Driver.listFromJson(jsonObject["MRData"]["DriverTable"]["Drivers"]);
          return {"data": drivers};
        default:
          return {"data": {"code": response.statusCode, "reason": response.reasonPhrase}};
      }
    } catch (e) {
      return {"data": e};
    }
  }
}
