abstract class AuthRemoteDataSource {
  /// signs in an existing user with given credentials
  ///
  /// returns uid of user
  ///
  /// throws a [AuthException] for all error codes
  Future<String> signin(String email, String password);

  /// creates a new user with given credentials, if any
  ///
  /// returns uid of user
  ///
  /// throws a [AuthException] for all error codes
  Future<String> signup(String email, String password);
}
