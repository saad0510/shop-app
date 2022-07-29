import 'package:multiple_result/multiple_result.dart';

import '../../../../core/entities/user_data.dart';
import '../../../../core/errors/failure.dart';
import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<Result<Failure, UserData>> signin(String email, String password);

  Future<Result<Failure, UserData>> signup(String email, String password);

  Future<Result<Failure, UserData>> forgotPassword(AuthUser email);

  Future<Result<Failure, UserData>> sendOtp(AuthUser email);

  Future<Result<Failure, UserData>> continueWithGoogle(AuthUser user);
}
