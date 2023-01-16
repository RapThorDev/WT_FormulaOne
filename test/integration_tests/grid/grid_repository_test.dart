import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final GridRepository repository = GridRepository();

  group("Grid Repository tests", () {
    test("Get filled list with year 2000", () async {
      final response = await repository.fetchGrid(2000);
      expect(response["data"].runtimeType, List<Driver>);
      expect(response["data"].isNotEmpty, true);
    });

    test("Get empty list with year 1000", () async {
      final response = await repository.fetchGrid(1000);
      expect(response["data"].isEmpty, true);
    });

    test("Get empty list with year 0", () async {
      final response = await repository.fetchGrid(0);
      expect(response["data"]["reason"], "Bad Request");
    });

    test("Get empty list with year -200", () async {
      final response = await repository.fetchGrid(-200);
      expect(response["data"].isEmpty, true);
    });
  });
}