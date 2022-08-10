import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injecetions.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/signin_user.dart';
import '../../domain/usecases/signout_user.dart';
import '../../domain/usecases/signup_user.dart';
import '../../domain/usecases/update_user.dart';
import 'auth_user_state.dart';

class AuthUserNotifier extends StateNotifier<AuthUserState> {
  final SigninUser signinUsecase;
  final SignupUser signupUsecase;
  final SignoutUser signoutUsecase;
  final UpdateUser updateUsecase;

  AuthUserNotifier({
    required this.signinUsecase,
    required this.signupUsecase,
    required this.signoutUsecase,
    required this.updateUsecase,
  }) : super(AuthUserEmpty());

  Future<void> signin(String email, String password) async {
    await _runEvent(
      () => signinUsecase(SigninParams(email, password)),
    );
  }

  Future<void> signup(UserData userData) async {
    await _runEvent(() => signupUsecase(userData));
  }

  Future<void> signout() async {
    state = AuthUserLoading();
    final result = await signoutUsecase();
    result.when(
      (error) => state = AuthUserError(message: error.message),
      (_) => state = AuthUserEmpty(),
    );
  }

  Future<void> update({
    String firstName = "",
    String lastName = "",
    String phone = "",
    String address = "",
  }) async {
    if (state is! AuthUserLoaded) {
      state = AuthUserError(
        message: "Cannot update a user unless he/she is logged in",
      );
    }
    final oldUser = (state as AuthUserLoaded).userData;
    final newUser = oldUser.copyWith(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
    );
    state = AuthUserLoading();

    final result = await updateUsecase(newUser);
    result.when(
      (error) => state = AuthUserError(message: error.message),
      (_) => state = AuthUserLoaded(userData: newUser),
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
