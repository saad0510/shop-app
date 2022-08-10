import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/user_data.dart';
import '../repositories/auth_repository.dart';

class SigninUser implements UseCase<UserData, SigninParams> {
  final AuthRepository _authRepo;

  const SigninUser(this._authRepo);

  @override
  Future<AuthResult> call(SigninParams params) async {
    return _authRepo.signin(params.email, params.password);
  }
}

class SigninParams extends Equatable {
  final String email;
  final String password;

  const SigninParams(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
