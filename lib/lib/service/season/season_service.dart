import 'package:f1_application/lib/datamanagement/repository/season_repository.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:flutter/cupertino.dart';

class SeasonService with ChangeNotifier {
  SeasonService();

  List<Season>? _seasons;
  List<Season> get getSeasonList => _seasons ?? [];

  bool _seasonsFetching = false;
  bool get isSeasonsFetching => _seasonsFetching;

  Season? _selectedSeason;
  Season? get getSelectedSeason => _selectedSeason;

  void setSelectedSeason(Season season) {
    _selectedSeason = season;
    notifyListeners();
  }

  Future<void> fetchSeasons() async {
    final seasonRepository = SeasonRepository();

    _seasonsFetching = true;
    notifyListeners();
    _seasons = await seasonRepository.fetchSeasons();
    _seasonsFetching = false;
    notifyListeners();
  }

  void sortSeasonListDescByYear() => _seasons?.sort((a, b) => Comparable.compare(b.year, a.year));

  void addDriversToSelectedSeason(List<Driver> drivers) {
    _selectedSeason!.addDrivers(drivers);
  }
}