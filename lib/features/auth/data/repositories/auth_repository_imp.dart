import 'package:multiple_result/multiple_result.dart';

import '../../../../core/entities/user_data.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

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
  Future<Result<Failure, UserData>> continueWithGoogle(AuthUser user) {
    // TODO: implement continueWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Result<Failure, UserData>> forgotPassword(AuthUser email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Result<Failure, UserData>> sendOtp(AuthUser email) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  Future<Result<Failure, UserData>> signin(
    String email,
    String password,
  ) async {
    try {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final userData = await remoteDataSource.signin(email, password);
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
  Future<Result<Failure, UserData>> signup(
    String email,
    String password,
  ) async {
    try {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final userData = await remoteDataSource.signup(email, password);
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
