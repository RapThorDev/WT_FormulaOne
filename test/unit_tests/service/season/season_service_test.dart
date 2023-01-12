import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/service/season/season_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final SeasonService service = SeasonService();

  final List<Season> seasons = [
    Season(year: "1991", wikiURL: "https://wikipedia.com", driverIds: []),
    Season(year: "1992", wikiURL: "https://wikipedia.com", driverIds: []),
    Season(year: "1993", wikiURL: "https://wikipedia.com", driverIds: []),
    Season(year: "1994", wikiURL: "https://wikipedia.com", driverIds: []),
    Season(year: "1995", wikiURL: "https://wikipedia.com", driverIds: []),
  ];

  group("Season Service test(s)", () {
    group("sortSeasonListDescByYear function test(s)", () {
      service.sortSeasonListDescByYear(seasons);

      test("After short the first season is 1995", () {
        expect(seasons.first.year == "1995", true);
      });
    });
  });
}