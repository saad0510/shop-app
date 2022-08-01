import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_data.dart';

abstract class UserRepository {
  Future<Result<Failure, UserData>> getUser(String uid);

  Future<Result<Failure, Void>> saveUser(UserData userData);
}
