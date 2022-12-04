import 'dart:io';

import 'package:f1_application/constants.dart';
import 'package:http/http.dart' as http;

class GoogleSearchApiClient {
  String baseUrl = Constants.googleApiBaseURL;
  String engineKey = Constants.googleEngineKey;
  String apiKey = Constants.googleApiKey;

  Future<http.Response> get({
    required String queryString,
}) async {
    String route = "$baseUrl?key=$apiKey&cx=$engineKey&q=$queryString";

    return http.get(
      Uri.parse(route),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      }
    );
}

}