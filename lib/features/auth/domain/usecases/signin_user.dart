import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../shared/user/domain/entities/user_data.dart';
import '../repositories/auth_repository.dart';

class SigninUser implements UseCase<UserData, SigninParams> {
  final AuthRepository _authRepo;

  SigninUser(this._authRepo);

  @override
  Future<Result<Failure, UserData>> call(SigninParams params) async {
    return _authRepo.signin(params.email, params.password);
  }
}

class SigninParams {
  final String email;
  final String password;
  const SigninParams(this.email, this.password);
}
