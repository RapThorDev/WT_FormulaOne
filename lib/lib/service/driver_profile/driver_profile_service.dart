import 'package:f1_application/lib/datamanagement/repository/driver_profile_repository.dart';
import 'package:flutter/cupertino.dart';

class DriverProfileService with ChangeNotifier {
  DriverProfileService();

  String? _googleImageUrl;
  String? get googleImageUrl => _googleImageUrl;

  bool _googleImageFetching = false;
  bool get isGoogleImageFetching => _googleImageFetching;

  Future<void> fetchDriverProfileImage(String driverLastName) async {
    final googleImageRepository = DriverProfileRepository();

    _googleImageFetching = true;
    notifyListeners();
    _googleImageUrl = await googleImageRepository.fetchGoogleImageUrl(driverLastName);
    _googleImageFetching = false;
    notifyListeners();
  }
}