import 'package:f1_application/lib/service/driver_profile/driver_profile_service.dart';

class DriverProfileViewModel {
  DriverProfileViewModel();

  String get imageUrl => DriverProfileService().googleImageUrl ?? "";
}
