// ignore_for_file: constant_identifier_names

class HttpCodes {
  HttpCodes._();

  // 2xx: Successful:

  /// 200 - The request is OK
  static const OK = 200;

  /// 201 - The request is complete, and a new resource is created
  static const Created = 201;

  /// 202 - The request is accepted for processing, but the processing is not complete
  static const Accepted = 202;

  // 4xx: Client Error:

  /// 400 - The server did not understand the request
  static const BadRequest = 400;

  /// 401 - The requested page needs a username and a password
  static const Unauthorized = 401;

  /// 403 - Access is forbidden to the requested page
  static const Forbidden = 403;

  /// 404 - The server can not find the requested page
  static const NotFound = 404;

  /// 405 - The method specified in the request is not allowed
  static const MethodNotAllowed = 405;

  /// 408 - The request took longer than the server was prepared to wait
  static const RequestTimeout = 408;

  // 5xx: Server Error

  /// 500 - The request was not completed The server met an unexpected condition
  static const InternalServerError = 500;

  /// 503 - The request was not completed The server is temporarily overloading or down
  static const ServiceUnavailable = 503;

  /// 504 - The gateway has timed out
  static const GatewayTimeout = 504;
}
