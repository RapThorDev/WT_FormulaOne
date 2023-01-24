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
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      return jsonObject["items"][0]["pagemap"]["cse_image"][0]["src"] ?? "";
    } catch (e) {
      throw _errorHandler.handle(e);
    }
  }
}
