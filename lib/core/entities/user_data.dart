class UserData {
  final String uid;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;

  UserData({
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
}
