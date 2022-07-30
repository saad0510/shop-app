import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_data.dart';

class NoReturn {
  const NoReturn();
}

abstract class UserRepository {
  Future<Result<Failure, UserData>> getUser(String uid);
  Future<Result<Failure, NoReturn>> saveUser(UserData userData);
}
