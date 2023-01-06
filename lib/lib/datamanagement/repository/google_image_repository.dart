import 'dart:convert';
import 'package:f1_application/lib/network/api/google_search_api_client.dart';
import 'package:flutter/cupertino.dart';

class GoogleImageRepository with ChangeNotifier {
  GoogleImageRepository();

  GoogleSearchApiClient clientGoogleSearch = GoogleSearchApiClient();

  String? _googleImageUrl;
  String? get getGoogleImageUrl => _googleImageUrl;

  bool _googleImageFetching = false;
  bool get isGoogleImageFetching => _googleImageFetching;

  Future<void> fetchGoogleImage(String driverLastName) async {
    try {
      _googleImageFetching = true;
      notifyListeners();
      final response =
          await clientGoogleSearch.get(queryString: driverLastName);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonObject = jsonDecode(response.body);
        _googleImageUrl =
            jsonObject["items"][0]["pagemap"]["cse_image"][0]["src"] ?? "";
      }
    } catch (e) {
      _googleImageUrl = "";
    }
    _googleImageFetching = false;
    notifyListeners();
  }
}
