import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SignoutUser implements UseCaseNoParam<SuccessResult> {
  final AuthRepository _authRepo;

  const SignoutUser(this._authRepo);

  @override
  Future<Result<Failure, SuccessResult>> call() async {
    return _authRepo.signout();
  }
}
