import 'package:f1_application/lib/datamanagement/repository/driver_profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';

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
    googleImageRepository.fetchGoogleImageUrl(driverLastName)
      ..then((url) => _googleImageUrl = url)
      ..catchError((e) {log("Error", error: e);});
    _googleImageFetching = false;
    notifyListeners();
  }
}