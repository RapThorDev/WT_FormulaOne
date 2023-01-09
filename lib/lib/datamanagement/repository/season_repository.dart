import 'dart:convert';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';
import 'package:flutter/cupertino.dart';

class SeasonRepository with ChangeNotifier {
  ErgastApiClient clientErgast = ErgastApiClient();

  List<Season>? _seasonList;
  List<Season>? get getSeasonList => _seasonList;

  void sortSeasonListDescByYear() => _seasonList?.sort((a, b) => Comparable.compare(b.year, a.year));

  bool _seasonsFetching = false;
  bool get isSeasonsFetching => _seasonsFetching;

  Future<void> fetchSeasons() async {
    try {
      _seasonsFetching = true;
      notifyListeners();
      final response = await clientErgast.get(type: GetType.season);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonObject = jsonDecode(response.body);
        _seasonList = Season.listFromJson(
            jsonObject["MRData"]["SeasonTable"]["Seasons"]);
        sortSeasonListDescByYear();
      }
    } catch (e) {
      _seasonList = [];
    }
    _seasonsFetching = false;
    notifyListeners();
  }

  Season? _selectedSeason;
  Season? get getSelectedSeason => _selectedSeason;

  void setSelectedSeason(Season season) {
    _selectedSeason = season;
    notifyListeners();
  }

  void addDriversToSelectedSeason(List<Driver> drivers) {
    _selectedSeason!.addDrivers(drivers);
  }
}
