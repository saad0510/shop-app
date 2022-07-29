import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/user/domain/entities/user_data.dart';
import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<Result<Failure, UserData>> signin(AuthUser authUser);

  Future<Result<Failure, UserData>> signup(AuthUser authUser);
}
