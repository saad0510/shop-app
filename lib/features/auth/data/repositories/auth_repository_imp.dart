import 'package:firebase_auth/firebase_auth.dart';
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

  const AuthRepositoryImp({
    required AuthRemoteDataSource remoteDataSource,
    required GetUser getUser,
    required SaveUser saveUser,
  })  : _remoteSrc = remoteDataSource,
        _getUser = getUser,
        _saveUser = saveUser;

  @override
  Future<AuthResult> signin(String email, String password) async {
    return _catchExceptions(() async {
      final uid = await _remoteSrc.signin(email, password);
      return _getUser(uid);
    });
  }

  @override
  Future<AuthResult> signup(UserData userData) async {
    return _catchExceptions(() async {
      final uid = await _remoteSrc.signup(userData.email, userData.password);
      final userWithUid = userData.copyWith(uid: uid);
      final result = await _saveUser(userWithUid);
      return result.isSuccess()
          ? Success(userWithUid)
          : Error(result.getError()!);
    });
  }

  @override
  Future<Result<Failure, SuccessResult>> signout() async {
    try {
      await _remoteSrc.signout();
      return const Success(success);
    } on AuthException catch (e) {
      return Error(AuthFailure(e.message));
    } on FirebaseAuthException catch (e) {
      return Error(AuthFailure(e.message ?? ""));
    }
  }

  Future<AuthResult> _catchExceptions(
    Future<AuthResult> Function() body,
  ) async {
    try {
      return await body();
    } on AuthException catch (e) {
      return Error(AuthFailure(e.message));
    } on FirebaseAuthException catch (e) {
      return Error(AuthFailure(e.message ?? ""));
    }
  }
}
