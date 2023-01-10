import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class GridViewModel {
  GridViewModel(this.context);

  final BuildContext context;

  bool get isGridFetching => Provider.of<GridService>(context).isGridFetching;

  List<Driver> get drivers => Provider.of<GridService>(context, listen: false).drivers;

  List<Driver> relevantDriversByExpression(String expression) {
    return Provider.of<GridService>(context).relevantDriversByExpression(expression);
  }
}