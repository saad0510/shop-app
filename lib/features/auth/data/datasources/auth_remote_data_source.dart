import '../../../../shared/user/data/models/user_data_model.dart';

abstract class AuthRemoteDataSource {
  /// signs in an existing user with given credentials
  ///
  /// throws a [AuthException] for all error codes
  Future<UserDataModel> signin(String email, String password);

  /// creates a new user with given credentials, if any
  ///
  /// throws a [AuthException] for all error codes
  Future<UserDataModel> signup(String email, String password);
}
