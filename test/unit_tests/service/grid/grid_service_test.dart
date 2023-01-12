import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';

void main() {
  final GridService service = GridService();

  final List<Driver> drivers = [
    Driver(id: "1", wikiURL: "https://wikipedia.com", firstName: "One", lastName: "Driver", dateOfBirth: "2001-01-01", nationality: "Italian", code: "DON", permanentNumber: "01"),
    Driver(id: "2", wikiURL: "https://wikipedia.com", firstName: "Two", lastName: "Driver", dateOfBirth: "2002-01-01", nationality: "Brazilian", code: "DTW", permanentNumber: "02"),
    Driver(id: "3", wikiURL: "https://wikipedia.com", firstName: "Three", lastName: "Driver", dateOfBirth: "2003-01-01", nationality: "Columbian", code: "DTH", permanentNumber: "03"),
    Driver(id: "4", wikiURL: "https://wikipedia.com", firstName: "Four", lastName: "Driver", dateOfBirth: "2004-01-01", nationality: "Hungarian", code: "DFO", permanentNumber: "04"),
    Driver(id: "5", wikiURL: "https://wikipedia.com", firstName: "Five", lastName: "Driver", dateOfBirth: "2005-01-01", nationality: "Brazilian", code: "DFI", permanentNumber: "05"),
  ];

  group("Grid Service test(s)", () {
    group("relevantDriversByExpression function test(s)", () {
      group("With drivers List", () {
        test("Get all driver with no expression ''", () {
          final result = service.relevantDriversByExpression(drivers, "");
          expect(const ListEquality().equals(result, drivers), true);
        });

        test("Get 'One Driver' driver with expression 'One'", () {
          final result = service.relevantDriversByExpression(drivers, "One");
          expect((
              result.contains(drivers[0]) && result.length == 1
          ), true);
        });

        test("Get 3 drivers with expression 'T'", () {
          final result = service.relevantDriversByExpression(drivers, "T");
          expect((
              result.contains(drivers[0]) &&
                  result.contains(drivers[1]) &&
                  result.contains(drivers[2]) &&
                  result.length == 3
          ), true);
        });

        test("Get all drivers with expression 'an'", () {
          final result = service.relevantDriversByExpression(drivers, "an");
          expect(const ListEquality().equals(result, drivers), true);
        });

        test("Get an empty list with expression 'ASDF'", () {
          final result = service.relevantDriversByExpression(drivers, "ASDF");
          expect(result.isEmpty, true);
        });
      });

      group("With empty list", () {
        test("Get an empty list with expression ''", () {
          final result = service.relevantDriversByExpression([], "");
          expect(result.isEmpty, true);
        });
      });
    });

    group("nationsSummary function test(s)", () {
      group("With drivers List", () {
        final result = service.nationsSummary(drivers);

        test("Get a 4 length Map", () {
          expect(result.length == 4, true);
        });

        test("The key 'Brazilian' is the first", () {
          expect(result.keys.toList().first == "Brazilian", true);
        });

        test("The key 'Brazilian' has value '2'", () {
          expect(result["Brazilian"] == 2, true);
        });

        test("Map entries keys not contains zero value", () {
          expect(result.values.toList().contains(0), false);
        });
      });

      group("With empty list", () {
        final result = service.nationsSummary([]);

        test("Get an empty Map", () {
          expect(result.isEmpty, true);
        });
      });
    });
  });
}