import 'package:f1_application/lib/datamanagement/repository/driver_profile_repository.dart';

class DriverProfileService {
  DriverProfileService();

  final DriverProfileRepository driverProfileRepository = DriverProfileRepository();

  Future<String> fetchDriverProfileImage(String driverLastName) async {
    return await driverProfileRepository.fetchGoogleImageUrl(driverLastName);
  }
}