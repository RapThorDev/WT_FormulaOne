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

  Map<String, dynamic>? _errorData;
  Map<String, dynamic> get errorData => _errorData ?? {};

  String? get errorReason => _errorData?["reason"] ?? "NO ERROR REASON";

  Future<void> fetchGrid(int seasonYear) async {

    _gridFetching = true;
    notifyListeners();
    final response = await _service.fetchGrid(0);
    if (response["data"] is List<Driver>) {
      _drivers = response["data"];
    } else {
      _errorData = response["data"];
    }
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