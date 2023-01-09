import 'package:f1_application/lib/model/driver.dart';

class DriverService {
  final Driver _driver;

  DriverService(this._driver);

  bool isExist(String value) {
    final List<String> searchableParams = [
      _driver.fullName.toLowerCase(),
      _driver.yearOfBirth,
      _driver.nationality.toLowerCase()
    ];

    return searchableParams.any((String param) => param.contains(value));
  }
}