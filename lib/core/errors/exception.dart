abstract class BaseException implements Exception {
  final String message;

  const BaseException(this.message);

  @override
  bool operator ==(covariant BaseException other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class AuthException extends BaseException {
  const AuthException([String message = ""]) : super(message);
}

class CacheException extends BaseException {
  const CacheException([String message = ""]) : super(message);
}

class DatabaseException extends BaseException {
  const DatabaseException([String message = ""]) : super(message);
}
