import 'dart:io';

import 'package:f1_application/constants.dart';
import 'package:http/http.dart' as http;


enum GetType {
  season,
  grid,
}

class ErgastApiClient {

  String baseUrl = Constants.apiBaseURL;

  Future<http.Response> get({
    required GetType type,
    int limit = 1000,
    int year = 1000,
  }) {
    String route;

    switch(type) {
      case GetType.season:
        route = "$baseUrl/seasons.json?limit=$limit";
        break;
      case GetType.grid:
        route = "$baseUrl/$year/drivers.json?limit=$limit";
        break;
    }

    return http.get(
        Uri.parse(route),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
    );
  }
}