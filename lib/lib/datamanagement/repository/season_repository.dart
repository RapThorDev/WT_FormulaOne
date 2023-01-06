import 'dart:convert';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/network/api/ergast_api_client.dart';
import 'package:flutter/cupertino.dart';

class SeasonRepository with ChangeNotifier {
  ErgastApiClient clientErgast = ErgastApiClient();

  List<SeasonModel>? _seasonList;
  List<SeasonModel>? get getSeasonList => _seasonList;

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
        _seasonList = SeasonModel.listFromJson(
            jsonObject["MRData"]["SeasonTable"]["Seasons"]);
        sortSeasonListDescByYear();
      }
    } catch (e) {
      _seasonList = [];
    }
    _seasonsFetching = false;
    notifyListeners();
  }

  SeasonModel? _selectedSeason;
  SeasonModel? get getSelectedSeason => _selectedSeason;

  void setSelectedSeason(SeasonModel season) {
    _selectedSeason = season;
    notifyListeners();
  }

  void addDriversToSelectedSeason(List<DriverModel> drivers) {
    _selectedSeason!.addDrivers(drivers);
  }
}
