import 'package:f1_application/lib/datamanagement/repository/season_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SeasonRepository repository = SeasonRepository();

  group("Grid Repository tests", () {
    test("Get filled list", () async {
      final response = await repository.fetchSeasons();
      expect(response.isNotEmpty, true);
    });
  });
}