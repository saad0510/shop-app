import '../enums/http_code.dart';

class HttpException implements Exception {
  final int code;
  final String prefix;
  final String message;

  const HttpException(
    this.prefix,
    this.code,
    this.message,
  );

  @override
  String toString() => "$prefix: $message";
}

class BadRequestException extends HttpException {
  const BadRequestException(
      [final String message = "The server did not understand the request"])
      : super(
          "BadRequestException",
          HttpCodes.BadRequest,
          message,
        );
}

class UnauthorizedException extends HttpException {
  const UnauthorizedException(
      [final String message =
          "The requested page needs a username and a password"])
      : super(
          "UnauthorizedException",
          HttpCodes.Unauthorized,
          message,
        );
}

class ForbiddenException extends HttpException {
  const ForbiddenException(
      [final String message = "Access is forbidden to the requested page"])
      : super(
          "ForbiddenException",
          HttpCodes.Forbidden,
          message,
        );
}

class NotFoundException extends HttpException {
  const NotFoundException(
      [final String message = "The server can not find the requested page"])
      : super(
          "NotFoundException",
          HttpCodes.NotFound,
          message,
        );
}

class MethodNotAllowedException extends HttpException {
  const MethodNotAllowedException(
      [final String message =
          "The method specified in the request is not allowed"])
      : super(
          "MethodNotAllowedException",
          HttpCodes.MethodNotAllowed,
          message,
        );
}

class RequestTimeoutException extends HttpException {
  const RequestTimeoutException(
      [final String message =
          "The request took longer than the server was prepared to wait"])
      : super(
          "RequestTimeoutException",
          HttpCodes.RequestTimeout,
          message,
        );
}

class InternalServerErrorException extends HttpException {
  const InternalServerErrorException(
      [final String message =
          "InternalServerErrorException request was not completed The server met an unexpected condition"])
      : super(
          "InternalServerError",
          HttpCodes.InternalServerError,
          message,
        );
}

class ServiceUnavailableException extends HttpException {
  const ServiceUnavailableException(
      [final String message =
          "ServiceUnavailableExceptione request was not completed The server is temporarily overloading or down"])
      : super(
          "ServiceUnavailable",
          HttpCodes.ServiceUnavailable,
          message,
        );
}

class GatewayTimeoutException extends HttpException {
  const GatewayTimeoutException(
      [final String message = "The gateway has timed out"])
      : super(
          "GatewayTimeoutException",
          HttpCodes.GatewayTimeout,
          message,
        );
}
