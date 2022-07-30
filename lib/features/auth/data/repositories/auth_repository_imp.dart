import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../shared/user/data/models/user_data_model.dart';
import '../../../../shared/user/domain/entities/user_data.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

// TODO: make dependencies private

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<Result<Failure, UserData>> signin(AuthUser authUser) async {
    return _signinOrSignupSelector(
      () => remoteDataSource.signin(authUser.email, authUser.password),
    );
  }

  @override
  Future<Result<Failure, UserData>> signup(AuthUser authUser) async {
    return _signinOrSignupSelector(
      () => remoteDataSource.signup(authUser.email, authUser.password),
    );
  }

  Future<Result<Failure, UserData>> _signinOrSignupSelector(
    Future<UserDataModel> Function() callback,
  ) async {
    try {
      final userData = await callback();
      return Success(userData);
    } on AuthException {
      return const Error(AuthFailure());
    }
  }
}
