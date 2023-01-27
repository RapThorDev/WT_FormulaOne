import 'dart:async';

import 'package:f1_application/lib/datamanagement/error_handler.dart';

class RequestHandler{
  Future<T> handle<T>(request) async {
    try {
      return await request();
    } catch (e) {
      throw ErrorHandler().handle(e);
    }
  }
}