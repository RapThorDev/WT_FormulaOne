class ErrorResponse implements Exception {
  ErrorResponse({this.statusCode, required this.reasonPhrase});

  final int? statusCode;
  final String reasonPhrase;

  @override
  String toString() {
    return statusCode != null ? "[$statusCode] $reasonPhrase" : reasonPhrase;
  }
}