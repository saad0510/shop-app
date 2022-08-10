import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_data.dart';

abstract class UserRepository {
  Future<Result<Failure, UserData>> getUser(String uid);

  Future<Result<Failure, SuccessResult>> saveUser(UserData userData);

  Future<Result<Failure, SuccessResult>> updateUser(UserData userData);
}
