import '../../../../core/entities/user_data.dart';
import '../../domain/entities/auth_user.dart';

abstract class AuthRemoteDataSource {
  Future<UserData> continueWithGoogle(AuthUser user);

  Future<UserData> forgotPassword(AuthUser email);

  Future<UserData> sendOtp(AuthUser email);

  /// signs in an existing user with given credentials
  ///
  /// throws a [AuthException] for all error codes
  Future<UserData> signin(String email, String password);

  /// creates a new user with given credentials
  ///
  /// throws a [AuthException] for all error codes
  Future<UserData> signup(String email, String password);
}
