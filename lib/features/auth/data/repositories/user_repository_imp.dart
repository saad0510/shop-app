import 'package:multiple_result/multiple_result.dart';

import '../../../../app/strings/error_strings.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_data_model.dart';

typedef UserEmptyResult = Result<Failure, SuccessResult>;

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
    return _catchErros(
      onConnected: () async {
        final userDataModel = await _remoteSrc.getUser(uid);
        await _localSrc.cacheUserData(userDataModel);
        return Success(userDataModel);
      },
      onDisconnected: () async {
        final userDataModel = await _localSrc.getLastUserData();
        if (userDataModel.uid == uid) {
          return Success(userDataModel);
        }
        throw const CacheException(ErrorStrings.cacheDifferentUser);
      },
    );
  }

  @override
  Future<Result<Failure, SuccessResult>> saveUser(UserData userData) async {
    // TODO: use firebase auth for uid
    return _catchErros(
      onConnected: () async {
        final userDataModel = UserDataModel.fromUserData(userData);
        await _remoteSrc.saveUser(userDataModel);
        await _localSrc.cacheUserData(userDataModel);
        return const Success(success);
      },
      onDisconnected: () async {
        throw const DatabaseException(ErrorStrings.databaseNetwork);
      },
    );
  }

  @override
  Future<Result<Failure, SuccessResult>> updateUser(UserData userData) async {
    return _catchErros(
      onConnected: () async {
        final userDataModel = UserDataModel.fromUserData(userData);
        await _remoteSrc.updateUser(userDataModel);
        await _localSrc.cacheUserData(userDataModel);
        return const Success(success);
      },
      onDisconnected: () async {
        throw const DatabaseException(ErrorStrings.databaseNetwork);
      },
    );
  }

  Future<Result<Failure, Return>> _catchErros<Return>({
    required Future<Result<Failure, Return>> Function() onConnected,
    required Future<Result<Failure, Return>> Function() onDisconnected,
  }) async {
    try {
      return await _networkInfo.isConnected
          ? await onConnected()
          : await onDisconnected();
    } on DatabaseException catch (e) {
      return Error(DatabaseFailure(e.message));
    } on CacheException catch (e) {
      return Error(CacheFailure(e.message));
    }
  }
}
