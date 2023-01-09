import 'dart:convert';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';
import 'package:flutter/cupertino.dart';

class GridRepository with ChangeNotifier {
  GridRepository();

  ErgastApiClient clientErgast = ErgastApiClient();

  bool _gridFetching = false;
  bool get isGridFetching => _gridFetching;

  Future<void> fetchGrid(Season season) async {
    try {
      _gridFetching = true;
      notifyListeners();
      final response =
          await clientErgast.get(type: GetType.grid, year: int.parse(season.year));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonObject = jsonDecode(response.body);
        List<Driver> drivers = Driver.listFromJson(
            jsonObject["MRData"]["DriverTable"]["Drivers"]);
        _gridDriverList = drivers;
        season.addDrivers(drivers);
      }
    } catch (e) {
      _gridDriverList = [];
    }
    _gridFetching = false;
    notifyListeners();
  }

  List<Driver>? _gridDriverList;
  List<Driver>? get getGridDriverList => _gridDriverList;

  Driver? _selectedDriver;
  Driver? get getSelectedDriver => _selectedDriver;

  void setSelectedDriver(Driver driver) {
    _selectedDriver = driver;
    notifyListeners();
  }
}
