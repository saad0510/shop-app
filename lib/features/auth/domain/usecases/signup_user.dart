import '../../../../core/usecases/usecase.dart';
import '../entities/user_data.dart';
import '../repositories/auth_repository.dart';

class SignupUser implements UseCase<UserData, UserData> {
  final AuthRepository _authRepo;

  SignupUser(this._authRepo);

  @override
  Future<AuthResult> call(UserData userData) async {
    return _authRepo.signup(userData);
  }
}
