import '../../domain/entities/user_data.dart';

abstract class UserState {}

class UserEmpty extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserData userData;

  UserLoaded({required this.userData});

  @override
  bool operator ==(covariant UserLoaded other) {
    return identical(this, other) || other.userData == userData;
  }

  @override
  int get hashCode => userData.hashCode;
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  bool operator ==(covariant UserError other) {
    return identical(this, other) || other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
