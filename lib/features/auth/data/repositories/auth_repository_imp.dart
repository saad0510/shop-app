import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../shared/user/domain/entities/user_data.dart';
import '../../../../shared/user/domain/usecases/get_user.dart';
import '../../../../shared/user/domain/usecases/save_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource _remoteSrc;
  final GetUser _getUser;
  final SaveUser _saveUser;

  AuthRepositoryImp({
    required AuthRemoteDataSource remoteDataSource,
    required GetUser getUser,
    required SaveUser saveUser,
  })  : _remoteSrc = remoteDataSource,
        _getUser = getUser,
        _saveUser = saveUser;

  @override
  Future<AuthResult> signin(String email, String password) async {
    try {
      final uid = await _remoteSrc.signin(email, password);
      return _getUser(uid);
    } on AuthException {
      return const Error(AuthFailure());
    }
  }

  @override
  Future<AuthResult> signup(UserData userData) async {
    try {
      final uid = await _remoteSrc.signup(userData.email, userData.password);
      final userWithUid = userData.copyWith(uid: uid);
      final result = await _saveUser(userWithUid);
      if (result.isSuccess()) {
        return Success(userWithUid);
      }
      return Error(result.getError()!);
    } on AuthException {
      return const Error(AuthFailure());
    }
  }
}
