import 'dart:convert';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';

class GridRepository {
  GridRepository();

  ErgastApiClient clientErgast = ErgastApiClient();

  Future<List<Driver>> fetchGrid(int  seasonYear) async {
    List<Driver> drivers = [];
    final response = await clientErgast.get(type: GetType.grid, year: seasonYear);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      drivers = Driver.listFromJson(jsonObject["MRData"]["DriverTable"]["Drivers"]);
    }
    return drivers;
  }
}
