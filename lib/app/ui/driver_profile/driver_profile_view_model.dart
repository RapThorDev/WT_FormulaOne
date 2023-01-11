import 'package:f1_application/lib/service/driver_profile/driver_profile_service.dart';
import 'package:flutter/cupertino.dart';

class DriverProfileViewModel with ChangeNotifier {
  DriverProfileViewModel();

  final DriverProfileService _service = DriverProfileService();

  String? _googleImageUrl;
  String? get imageUrl => _googleImageUrl;

  bool _googleImageFetching = false;
  bool get isDriverProfileFetching => _googleImageFetching;

  Future<void> fetchDriverProfileImage(String driverLastName) async {
    _googleImageFetching = true;
    notifyListeners();
    _googleImageUrl = await _service.fetchDriverProfileImage(driverLastName);
    _googleImageFetching = false;
    notifyListeners();
  }
}
