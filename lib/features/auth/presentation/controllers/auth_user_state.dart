import '../../domain/entities/user_data.dart';

abstract class AuthUserState {}

class AuthUserEmpty extends AuthUserState {}

class AuthUserLoading extends AuthUserState {}

class AuthUserLoaded extends AuthUserState {
  final UserData userData;

  AuthUserLoaded({required this.userData});

  @override
  bool operator ==(covariant AuthUserLoaded other) {
    return identical(this, other) || other.userData == userData;
  }

  @override
  int get hashCode => userData.hashCode;
}

class AuthUserError extends AuthUserState {
  final String message;

  AuthUserError({required this.message});

  @override
  bool operator ==(covariant AuthUserError other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
