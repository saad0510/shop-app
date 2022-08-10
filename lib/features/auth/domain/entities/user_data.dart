import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String uid;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;

  const UserData({
    required this.uid,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

  const UserData.only({
    this.uid = "",
    this.email = "",
    this.password = "",
    this.firstName = "",
    this.lastName = "",
    this.phone = "",
    this.address = "",
  });

  @override
  List<Object?> get props =>
      [uid, email, password, firstName, lastName, phone, address];

  UserData copyWith({
    String? uid,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
