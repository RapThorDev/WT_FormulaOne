import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/model/driver.dart';

class GridService {
  final GridRepository _gridRepository;

  GridService(this._gridRepository);

  List<Driver> get drivers => _gridRepository.getGridDriverList ?? [];

  List<Driver> relevantDriversByExpression(String expression) => drivers.where((driver) => _isRelevantDriver(driver, expression)).toList() ?? [];

  bool _isRelevantDriver(Driver driver, String expression) {
    final List<String> searchableParams = [
      driver.fullName.toLowerCase(),
      driver.yearOfBirth,
      driver.nationality.toLowerCase()
    ];

    return searchableParams.any((String param) => param.contains(expression.toLowerCase()));
  }

  Map<String, int?> nationsSummary() {
    Map<String, int> nations = _driversNationsGroup();

    List<String> sortedKeys = nations.keys.toList(growable: false)
      ..sort((keyA, keyB) => nations[keyB]!.compareTo(nations[keyA]!.toInt()));
    Map<String, int?> sortedNations = { for (var key in sortedKeys) key: nations[key]};

    return sortedNations;
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