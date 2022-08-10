import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exception.dart';

abstract class AuthRemoteDataSource {
  /// signs in an existing user with given credentials
  ///
  /// returns uid of user
  ///
  /// throws a [AuthException] for all error codes
  Future<String> signin(String email, String password);

  /// creates a new user with given credentials, if any
  ///
  /// returns uid of user
  ///
  /// throws a [AuthException] for all error codes
  Future<String> signup(String email, String password);
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImp({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<String> signin(String email, String password) async {
    return _signinOrSignupSelector(
      () => _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<String> signup(String email, String password) {
    return _signinOrSignupSelector(
      () => _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<String> _signinOrSignupSelector(
    Future<UserCredential> Function() body,
  ) async {
    await body();
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.uid;
    }
    throw const AuthException("signin/signup failed. returned user was null");
  }
}
