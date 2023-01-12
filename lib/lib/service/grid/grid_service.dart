import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/model/driver.dart';

class GridService {
  GridService();

  final GridRepository gridRepository = GridRepository();

  Future<List<Driver>> fetchGrid(int seasonYear) async {
    return await gridRepository.fetchGrid(seasonYear);
  }

  List<Driver> relevantDriversByExpression(List<Driver> drivers, String expression) => drivers.where((driver) => _isRelevantDriver(driver, expression)).toList();

  Map<String, int> nationsSummary(List<Driver> drivers) {
    Map<String, int> nations = _driversNationsGroup(drivers);

    List<String> sortedKeys = nations.keys.toList(growable: false)
      ..sort((keyA, keyB) => nations[keyB]!.compareTo(nations[keyA]!.toInt()));
    Map<String, int> sortedNations = { for (var key in sortedKeys) key: nations[key]!};

    return sortedNations;
  }

  bool _isRelevantDriver(Driver driver, String expression) {
    final List<String> searchableParams = [
      driver.fullName.toLowerCase(),
      driver.yearOfBirth,
      driver.nationality.toLowerCase()
    ];

    return searchableParams.any((String param) => param.contains(expression.toLowerCase()));
  }

  Map<String, int> _driversNationsGroup(List<Driver> drivers) {
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