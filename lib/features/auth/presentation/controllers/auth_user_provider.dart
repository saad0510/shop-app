import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injecetions.dart';
import '../../domain/entities/user_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/signin_user.dart';
import '../../domain/usecases/signout_user.dart';
import '../../domain/usecases/signup_user.dart';
import '../../domain/usecases/update_user.dart';
import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final SigninUser signinUsecase;
  final SignupUser signupUsecase;
  final SignoutUser signoutUsecase;
  final UpdateUser updateUsecase;

  UserNotifier({
    required this.signinUsecase,
    required this.signupUsecase,
    required this.signoutUsecase,
    required this.updateUsecase,
  }) : super(UserEmpty());

  Future<void> signin(String email, String password) async {
    await _runEvent(
      () => signinUsecase(SigninParams(email, password)),
    );
  }

  Future<void> signup(UserData userData) async {
    await _runEvent(() => signupUsecase(userData));
  }

  Future<void> signout() async {
    state = UserLoading();
    final result = await signoutUsecase();
    result.when(
      (error) => state = UserError(message: error.message),
      (_) => state = UserEmpty(),
    );
  }

  Future<void> update({
    String firstName = "",
    String lastName = "",
    String phone = "",
    String address = "",
  }) async {
    if (state is! UserLoaded) {
      state = UserError(message: "user needs to be logged in for update");
    }
    final oldUser = (state as UserLoaded).userData;
    final newUser = oldUser.copyWith(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
    );
    state = UserLoading();

    final result = await updateUsecase(newUser);
    result.when(
      (error) => state = UserError(message: error.message),
      (_) => state = UserLoaded(userData: newUser),
    );
  }

  Future<void> _runEvent(Future<AuthResult> Function() body) async {
    state = UserLoading();
    final result = await body();
    result.when(
      (error) {
        state = UserError(message: error.message);
      },
      (userData) {
        state = UserLoaded(userData: userData);
      },
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => locator<UserNotifier>(),
);
