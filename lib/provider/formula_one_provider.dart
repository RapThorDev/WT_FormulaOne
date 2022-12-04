import 'dart:convert';

import 'package:f1_application/api_extensions/google_search_api_client.dart';
import 'package:f1_application/model/driver.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_extensions/ergast_api_client.dart';
import '../model/season.dart';

class FormulaOneProvider with ChangeNotifier {

  FormulaOneProvider(this.preferences) {}

  final SharedPreferences preferences;

  Future<void> waitTwoSec() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  static ErgastApiClient clientErgast = ErgastApiClient();
  static GoogleSearchApiClient clientGoogleSearch = GoogleSearchApiClient();

  // === SEASONS ===
  List<SeasonModel> _seasonList = [];
  List<SeasonModel> get getSeasonList => _seasonList;

  bool _seasonsFetching = false;
  bool get isSeasonsFetching => _seasonsFetching;

  Future<void> fetchSeasons() async {
    try {
      _seasonsFetching = true;
      notifyListeners();
      final response = await clientErgast.get(type: GetType.season);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonObject = jsonDecode(response.body);
        _seasonList = SeasonModel.listFromJson(jsonObject["MRData"]["SeasonTable"]["Seasons"]);
        // Descending order by year
        _seasonList.sort((a, b) => Comparable.compare(b.year, a.year));
      }
    } catch(e) {
      waitTwoSec();
      _seasonList = [];
    }
    _seasonsFetching = false;
    notifyListeners();
  }

  late SeasonModel _selectedSeason;
  SeasonModel get getSelectedSeason => _selectedSeason;

  void setSelectedSeason(SeasonModel season) {
    _selectedSeason = season;
    notifyListeners();
  }

  // === DRIVERS ===
  List<DriverModel> _driverList = [];
  List<DriverModel> get getDriverList => _driverList;

  late DriverModel _selectedDriver;
  DriverModel get getSelectedDriver => _selectedDriver;

  void setSelectedDriver(DriverModel driver) {
    _selectedDriver = driver;
    notifyListeners();
  }

  DriverModel? _searchedDriver;
  DriverModel? get getSearchedDriver => _searchedDriver;

  void setSearchedDriver(DriverModel driver) {
    _searchedDriver = driver;
    notifyListeners();
  }


  // === GRID ===
  bool _gridFetching = false;
  bool get isGridFetching => _gridFetching;

  Future<void> fetchGrid() async {
    try {
      _gridFetching = true;
      notifyListeners();
      final response = await clientErgast.get(type: GetType.grid, year: int.parse(_selectedSeason.year));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonObject = jsonDecode(response.body);
        List<DriverModel> drivers = DriverModel.listFromJson(jsonObject["MRData"]["DriverTable"]["Drivers"]);
        for (var driver in drivers) {
          _selectedSeason.driverIds.add(driver.id);
          if (!_driverList.contains(driver)) {
            _driverList.add(driver);
          }
        }}
    } catch (e) {
      waitTwoSec();
      _seasonList = [];
    }
    _gridFetching = false;
    notifyListeners();
  }

  // === GOOGLE IMAGE ===

  String _googleImageUrl = "";
  String get getGoogleImageUrl => _googleImageUrl;

  bool _googleImageFetching = false;
  bool get isGoogleImageFetching => _googleImageFetching;

  Future<void> fetchGoogleImage() async {
    try {
      _googleImageFetching = true;
      notifyListeners();
      final response = await clientGoogleSearch.get(queryString: _selectedDriver.lastName);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonObject = jsonDecode(response.body);
        _googleImageUrl = jsonObject["items"][0]["pagemap"]["cse_image"][0]["src"] ?? "";
      }
    } catch (e) {
      waitTwoSec();
      _googleImageUrl = "";
    }
    _googleImageFetching = false;
    notifyListeners();
  }
}
