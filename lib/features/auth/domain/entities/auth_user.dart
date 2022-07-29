class AuthUser {
  final String uid;
  final String email;
  final String password;

  const AuthUser({
    required this.uid,
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(covariant AuthUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ email.hashCode ^ password.hashCode;
  }
}
