import 'dart:async';

import 'package:f1_application/lib/datamanagement/error_handler.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';

class RequestHandler{
  Future<dynamic> _handle(request) async {
    try {
      final result = await request();
      return result;
    } catch (e) {
      throw ErrorHandler().handle(e);
    }
  }

  Future<String> handleFetchGoogleImageUrl(request) async => await _handle(request);
  Future<List<Driver>> handleFetchGrid(request) async => await _handle(request);
  Future<List<Season>> handleFetchSeason(request) async => await _handle(request);
}