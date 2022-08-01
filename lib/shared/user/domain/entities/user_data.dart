class UserData {
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

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.password == password &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.address == address;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        password.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        address.hashCode;
  }

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
