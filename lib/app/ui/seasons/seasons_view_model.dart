import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/service/season/season_service.dart';
import 'package:flutter/cupertino.dart';

class SeasonViewModel with ChangeNotifier {
  SeasonViewModel();

  final SeasonService _service = SeasonService();

  List<Season>? _seasons;
  List<Season> get seasons => _seasons ?? [];

  bool _seasonsFetching = false;
  bool get isSeasonsFetching => _seasonsFetching;

  Future<void> fetchSeasons() async {

    _seasonsFetching = true;
    notifyListeners();
    _seasons = await _service.fetchSeasons();
    _seasonsFetching = false;
    notifyListeners();
  }

  void orderSeasonsDescByYear() => _service.sortSeasonListDescByYear(seasons);

}