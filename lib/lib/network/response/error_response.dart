class ErrorResponse implements Exception {
  ErrorResponse(this.statusCode, this.reasonPhrase);

  final int statusCode;
  final String reasonPhrase;

  @override
  String toString() {
    return "[$statusCode] $reasonPhrase";
  }
}