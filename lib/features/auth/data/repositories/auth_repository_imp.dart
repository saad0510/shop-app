import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../shared/user/domain/entities/user_data.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

// TODO: make dependencies private

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<Failure, UserData>> signin(AuthUser authUser) async {
    try {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final userData = await remoteDataSource.signin(
          authUser.email,
          authUser.password,
        );
        await localDataSource.cacheUserData(userData);
        return Success(userData);
      }
      final userData = await localDataSource.getLastUserData();
      return Success(userData);
    } on AuthException {
      return const Error(AuthFailure());
    } on CacheException {
      return const Error<Failure, UserData>(CacheFailure());
    }
  }

  @override
  Future<Result<Failure, UserData>> signup(AuthUser authUser) async {
    try {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final userData = await remoteDataSource.signup(
          authUser.email,
          authUser.password,
        );
        await localDataSource.cacheUserData(userData);
        return Success(userData);
      }
      final userData = await localDataSource.getLastUserData();
      return Success(userData);
    } on AuthException {
      return const Error(AuthFailure());
    } on CacheException {
      return const Error<Failure, UserData>(CacheFailure());
    }
  }
}
