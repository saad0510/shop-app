import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  final String message;

  const BaseException([this.message = ""]);

  @override
  List<Object?> get props => [message];
}

class AuthException extends BaseException {
  const AuthException([super.message]);
}

class CacheException extends BaseException {
  const CacheException([super.message]);
}

class DatabaseException extends BaseException {
  const DatabaseException([super.message]);
}

class RouteException extends BaseException {
  const RouteException([super.message]);
}
