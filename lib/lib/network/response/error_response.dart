class ErrorResponse implements Exception {
  ErrorResponse({this.statusCode = -1, required this.reasonPhrase});

  final int statusCode;
  final String reasonPhrase;

  @override
  String toString() {
    return statusCode != -1 ? "[$statusCode] $reasonPhrase" : reasonPhrase;
  }
}