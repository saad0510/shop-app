abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  bool operator ==(covariant Failure other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class AuthFailure extends Failure {
  const AuthFailure([String message = ""]) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = ""]) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([String message = ""]) : super(message);
}
