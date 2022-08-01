import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_data_model.dart';

class UserRepositoryImp extends UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<Failure, UserData>> getUser(String uid) async {
    try {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final userDataModel = await remoteDataSource.getUser(uid);
        await localDataSource.cacheUserData(userDataModel);
        return Success(userDataModel);
      }
      final userDataModel = await localDataSource.getLastUserData();
      if (userDataModel.uid == uid) {
        return Success(userDataModel);
      }
      return const Error(CacheFailure());
    } on DatabaseException {
      return const Error(DatabaseFailure());
    } on CacheException {
      return const Error(CacheFailure());
    }
  }

  @override
  Future<Result<Failure, NoReturn>> saveUser(UserData userData) async {
    try {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final userDataModel = userData as UserDataModel;
        await remoteDataSource.saveUser(userDataModel);
        await localDataSource.cacheUserData(userDataModel);
        return const Success(NoReturn());
      }
      return const Error(DatabaseFailure());
    } on DatabaseException {
      return const Error(DatabaseFailure());
    } on CacheException {
      return const Error(CacheFailure());
    }
  }
}
