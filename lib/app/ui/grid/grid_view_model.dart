import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:flutter/cupertino.dart';

class GridViewModel with ChangeNotifier {
  GridViewModel();

  final GridService _service = GridService();

  bool _gridFetching = false;

  bool get isGridFetching => _gridFetching;

  List<Driver>? _drivers;

  List<Driver> get drivers => _drivers ?? [];

  Future<void> fetchGrid(int seasonYear) async {
    _gridFetching = true;
    notifyListeners();
    _drivers = await _service.fetchGrid(seasonYear);
    _gridFetching = false;
    notifyListeners();
  }

  List<Driver> relevantDriversByExpression(String expression) {
    return _service.relevantDriversByExpression(drivers, expression);
  }

  Map<String, int> nationsSummary() {
    return _service.nationsSummary(drivers);
  }
}