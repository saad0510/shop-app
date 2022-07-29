import 'package:multiple_result/multiple_result.dart';

import '../../../../core/entities/user_data.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class SignupUser implements UseCase<UserData, AuthUser> {
  final AuthRepository _authRepo;

  SignupUser(this._authRepo);

  @override
  Future<Result<Failure, UserData>> call(AuthUser authUser) async {
    return await _authRepo.signup(
      authUser.email,
      authUser.password,
    );
  }
}
