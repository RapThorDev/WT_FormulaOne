import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/network/response/error_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final GridRepository repository = GridRepository();

  group("Grid Repository tests", () {
    test("Get filled list with year 2000", () async {
      final response = await repository.fetchGrid(2000);
      expect(response.isNotEmpty, true);
    });

    test("Get empty list with year 1000", () async {
      final response = await repository.fetchGrid(1000);
      expect(response.isEmpty, true);
    });

    test("Get empty list with year 0", () async {
      expect(() => repository.fetchGrid(0), throwsA(isA<ErrorResponse>()));
    });

    test("Get empty list with year -200", () async {
      final response = await repository.fetchGrid(-200);
      expect(response.isEmpty, true);
    });
  });
}