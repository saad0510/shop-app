// ignore_for_file: avoid_renaming_method_parameters

import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_data.dart';
import '../repositories/user_repository.dart';

class GetUser extends UseCase<UserData, String> {
  final UserRepository _repo;

  GetUser(this._repo);

  @override
  Future<Result<Failure, UserData>> call(String uid) async {
    return _repo.getUser(uid);
  }
}
