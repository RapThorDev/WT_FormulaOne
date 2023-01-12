import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final GridRepository repository = GridRepository();

  group("Grid successful tests", () {
    test("Get filled list with year 2000", () async {
      final response = await repository.fetchGrid(2000);
      expect(response.isNotEmpty, true);
    });

    test("Get empty list with year 1000", () async {
      final response = await repository.fetchGrid(1000);
      expect(response.isEmpty, true);
    });

    test("Get empty list with year 0", () async {
      final response = await repository.fetchGrid(0);
      expect(response.isEmpty, true);
    });

    test("Get empty list with year -200", () async {
      final response = await repository.fetchGrid(-200);
      expect(response.isEmpty, true);
    });
  });
}