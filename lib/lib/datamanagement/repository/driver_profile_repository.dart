import 'dart:convert';
import 'package:f1_application/lib/datamanagement/error_handler.dart';
import 'package:f1_application/lib/network/api/google_search_api_client.dart';

class DriverProfileRepository {
  DriverProfileRepository();

  final GoogleSearchApiClient clientGoogleSearch = GoogleSearchApiClient();

  final ErrorHandler _errorHandler = ErrorHandler();

  Future<String> fetchGoogleImageUrl(String driverLastName) async {
    try {
      final response = await clientGoogleSearch.get(queryString: driverLastName);
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonObject = jsonDecode(response.body);
          return jsonObject["items"][0]["pagemap"]["cse_image"][0]["src"] ?? "";
        default:
          throw _errorHandler.getErrorResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }
}
