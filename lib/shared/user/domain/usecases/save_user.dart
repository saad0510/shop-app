// ignore_for_file: avoid_renaming_method_parameters

import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_data.dart';
import '../repositories/user_repository.dart';

class SaveUser extends UseCase<bool, UserData> {
  final UserRepository _repo;

  SaveUser(this._repo);

  @override
  Future<Result<Failure, bool>> call(UserData user) async {
    await _repo.saveUser(user);
    return const Success(true);
  }
}
