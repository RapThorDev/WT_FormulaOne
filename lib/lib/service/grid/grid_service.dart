import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:flutter/cupertino.dart';

class GridService with ChangeNotifier {
  GridService();

  bool _gridFetching = false;
  bool get isGridFetching => _gridFetching;

  List<Driver>? _drivers;
  List<Driver> get drivers => _drivers ?? [];

  Driver? _selectedDriver;
  Driver? get selectedDriver => _selectedDriver;

  Future<void> fetchGrid(int seasonYear) async {
    final gridRepository = GridRepository();

    _gridFetching = true;
    notifyListeners();
    _drivers = await gridRepository.fetchGrid(seasonYear);
    _gridFetching = false;
    notifyListeners();
  }

  List<Driver> relevantDriversByExpression(String expression) => drivers.where((driver) => _isRelevantDriver(driver, expression)).toList();

  Map<String, int> nationsSummary() {
    Map<String, int> nations = _driversNationsGroup();

    List<String> sortedKeys = nations.keys.toList(growable: false)
      ..sort((keyA, keyB) => nations[keyB]!.compareTo(nations[keyA]!.toInt()));
    Map<String, int> sortedNations = { for (var key in sortedKeys) key: nations[key]!};

    return sortedNations;
  }

  void setSelectedDriver(Driver driver) {
    _selectedDriver = driver;
    notifyListeners();
  }

  bool _isRelevantDriver(Driver driver, String expression) {
    final List<String> searchableParams = [
      driver.fullName.toLowerCase(),
      driver.yearOfBirth,
      driver.nationality.toLowerCase()
    ];

    return searchableParams.any((String param) => param.contains(expression.toLowerCase()));
  }

  Map<String, int> _driversNationsGroup() {
    Map<String, int> nationsSummary = {};
    for (Driver driver in drivers) {
      if (!nationsSummary.containsKey(driver.nationality)) {
        nationsSummary[driver.nationality] = 1;
      } else {
        nationsSummary[driver.nationality] = nationsSummary[driver.nationality]! + 1;
      }
    }
    return nationsSummary;
  }
}