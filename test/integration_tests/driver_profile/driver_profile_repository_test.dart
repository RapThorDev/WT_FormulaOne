import 'package:f1_application/lib/datamanagement/repository/driver_profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DriverProfileRepository repository = DriverProfileRepository();

  group("Driver Profile Repository tests", () {
    test("Get URL String with driver last name 'Schumacher'", () async {
      final response = await repository.fetchGoogleImageUrl("Schumacher");
      expect(response.isNotEmpty, true);
    });

    test("Call fetch function with empty String", () async {
      final response = await repository.fetchGoogleImageUrl("");
      expect(response, "");
    });
  });
}