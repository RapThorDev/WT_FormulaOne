import 'dart:convert';
import 'dart:developer';
import 'package:f1_application/lib/datamanagement/error_handler.dart';
import 'package:f1_application/lib/network/api/google_search_api_client.dart';

class DriverProfileRepository {
  DriverProfileRepository();

  final GoogleSearchApiClient clientGoogleSearch = GoogleSearchApiClient();

  final ErrorHandler _errorHandler = ErrorHandler();

  Future<String> fetchGoogleImageUrl(String driverLastName) async {
    String url = "";
    try {
      final response = await clientGoogleSearch.get(queryString: driverLastName);
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonObject = jsonDecode(response.body);
          url = jsonObject["items"][0]["pagemap"]["cse_image"][0]["src"] ?? "";
          break;
        default:
          throw _errorHandler.getErrorResponse(response);
      }
    } catch (e) {
      log(e.toString());
    }
    return url;
  }
}
