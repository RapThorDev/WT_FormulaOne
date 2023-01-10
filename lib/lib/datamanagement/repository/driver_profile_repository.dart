import 'dart:convert';
import 'package:f1_application/lib/network/api/google_search_api_client.dart';
import 'dart:developer';

class DriverProfileRepository {
  DriverProfileRepository();

  GoogleSearchApiClient clientGoogleSearch = GoogleSearchApiClient();

  Future<String> fetchGoogleImageUrl(String driverLastName) async {
    log("DriverProfileImageFetch");
    String url = "";
    final response = await clientGoogleSearch.get(queryString: driverLastName);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      url = jsonObject["items"][0]["pagemap"]["cse_image"][0]["src"] ?? "";
    }
    return url;
  }
}
