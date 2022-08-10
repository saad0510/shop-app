import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../injecetions.dart';
import '../../../../shared/user/domain/entities/user_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/signin_user.dart';
import '../../domain/usecases/signout_user.dart';
import '../../domain/usecases/signup_user.dart';
import 'auth_user_state.dart';

// TODO: make dependencies private

class AuthUserNotifier extends StateNotifier<AuthUserState> {
  final SigninUser signinUser;
  final SignupUser signupUser;
  final SignoutUser signoutUser;

  AuthUserNotifier({
    required this.signinUser,
    required this.signupUser,
    required this.signoutUser,
  }) : super(AuthUserEmpty());

  AuthUserState getState() => state;

  Future<void> signin(String email, String password) async {
    await _runEvent(
      () => signinUser(SigninParams(email, password)),
    );
  }

  Future<void> mockSignup(UserData userData) async {
    await _runEvent(() async => Success(userData));
  }

  Future<void> signup(UserData userData) async {
    await _runEvent(() => signupUser(userData));
  }

  Future<void> signout() async {
    state = AuthUserLoading();
    final result = await signoutUser();
    result.when(
      (error) {
        state = AuthUserError(message: error.message);
      },
      (_) {
        state = AuthUserEmpty();
      },
    );
  }

  Future<void> _runEvent(Future<AuthResult> Function() body) async {
    state = AuthUserLoading();
    final result = await body();
    result.when(
      (error) {
        state = AuthUserError(message: error.message);
      },
      (userData) {
        state = AuthUserLoaded(userData: userData);
      },
    );
  }
}

final authUserProvider = StateNotifierProvider<AuthUserNotifier, AuthUserState>(
  (ref) => locator<AuthUserNotifier>(),
);
