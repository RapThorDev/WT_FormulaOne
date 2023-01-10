import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/service/season/season_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SeasonViewModel {
  SeasonViewModel(this.context);

  final BuildContext context;

  List<Season> get seasons => Provider.of<SeasonService>(context, listen: false).getSeasonList;

  Season? get selectedSeason => Provider.of<SeasonService>(context, listen: false).getSelectedSeason;

  void orderSeasonsDescByYear() => Provider.of<SeasonService>(context, listen: false).sortSeasonListDescByYear();

}