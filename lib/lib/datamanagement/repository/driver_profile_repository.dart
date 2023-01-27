import 'dart:async';
import 'dart:convert';
import 'package:f1_application/lib/network/api/google_search_api_client.dart';
import 'package:f1_application/lib/network/request/request_handler.dart';
import 'package:http/http.dart';

class DriverProfileRepository {
  DriverProfileRepository();

  final GoogleSearchApiClient clientGoogleSearch = GoogleSearchApiClient();
  final RequestHandler _handler = RequestHandler();

  Future<String> fetchGoogleImageUrl(String driverLastName) async {
    return await _handler.handle(() async {
      Response response = await clientGoogleSearch.get(queryString: driverLastName).timeout(const Duration(seconds: 10));
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      return jsonObject["items"][0]["pagemap"]["cse_image"][0]["src"] ?? "";
    });

  }
}
