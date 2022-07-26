class RouteException implements Exception {
  final String message;

  RouteException([this.message = "empty error"]);

  @override
  String toString() => 'RouteError(message: $message)';
}
