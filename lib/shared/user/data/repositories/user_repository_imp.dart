import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_data_model.dart';

class UserRepositoryImp extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<Result<Failure, UserData>> getUser(String uid) async {
    try {
      final userDataModel = await remoteDataSource.getUser(uid);
      return Success(userDataModel);
    } on DatabaseException {
      return const Error(DatabaseFailure());
    }
  }

  @override
  Future<Result<Failure, void>> saveUser(UserData userData) async {
    try {
      await remoteDataSource.saveUser(userData as UserDataModel);
      return const Success(true);
    } on DatabaseException {
      return const Error(DatabaseFailure());
    }
  }
}
