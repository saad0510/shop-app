import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_data_model.dart';

class UserRepositoryImp extends UserRepository {
  final UserRemoteDataSource _remoteSrc;
  final UserLocalDataSource _localSrc;
  final NetworkInfo _networkInfo;

  UserRepositoryImp({
    required UserRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteSrc = remoteDataSource,
        _localSrc = localDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Result<Failure, UserData>> getUser(String uid) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final userDataModel = await _remoteSrc.getUser(uid);
        await _localSrc.cacheUserData(userDataModel);
        return Success(userDataModel);
      }
      final userDataModel = await _localSrc.getLastUserData();
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
  Future<Result<Failure, Void>> saveUser(UserData userData) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final userDataModel = userData as UserDataModel;
        await _remoteSrc.saveUser(userDataModel);
        await _localSrc.cacheUserData(userDataModel);
        return const Success(Void());
      }
      return const Error(DatabaseFailure());
    } on DatabaseException {
      return const Error(DatabaseFailure());
    } on CacheException {
      return const Error(CacheFailure());
    }
  }
}
