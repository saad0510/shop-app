import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/user/domain/entities/user_data.dart';

typedef AuthResult = Result<Failure, UserData>;

abstract class AuthRepository {
  Future<AuthResult> signin(String email, String password);

  Future<AuthResult> signup(UserData userData);
}
