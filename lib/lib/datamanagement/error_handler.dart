import 'package:http/http.dart';
import 'package:f1_application/lib/network/response/error_response.dart';

class ErrorHandler {
  ErrorResponse getErrorResponse(Response response) {
    return ErrorResponse(response.statusCode, response.reasonPhrase!);
  }
}