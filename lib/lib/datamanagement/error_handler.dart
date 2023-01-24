import 'dart:io';

import 'package:http/http.dart';
import 'package:f1_application/lib/network/response/error_response.dart';

class ErrorHandler {
  ErrorResponse getErrorResponse(Response response) {
    return ErrorResponse(statusCode: response.statusCode, reasonPhrase: response.reasonPhrase!);
  }
  
  ErrorResponse handle(Object error) {
    if (error is SocketException) {
      return ErrorResponse(reasonPhrase: "No internet connection");
    } else if (error is FormatException || error is NoSuchMethodError) {
      return ErrorResponse(statusCode: 400, reasonPhrase: "Bad request");
    } else if (error is TypeError) {
      return ErrorResponse(reasonPhrase: "Not found this key on jsonObject");
    } else {
      return ErrorResponse(reasonPhrase: error.toString());
    }
  }
}