import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/core/errors/failure.dart';

import '../entities/user_data.dart';

abstract class UserRepository {
  Future<Result<Failure, UserData>> getUser(String uid);
  Future<Result<Failure, bool>> saveUser(UserData userData);
}
