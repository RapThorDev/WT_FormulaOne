import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:f1_application/lib/service/season/season_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class GridViewModel {
  GridViewModel(this.context);

  final BuildContext context;

  Season? get selectedSeason => Provider.of<SeasonService>(context, listen: false).getSelectedSeason;

  List<Driver> get drivers => Provider.of<GridService>(context, listen: false).drivers;

  List<Driver> relevantDriversByExpression(String expression) {
    return Provider.of<GridService>(context).relevantDriversByExpression(expression);
  }
}