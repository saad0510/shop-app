import '../../domain/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required String uid,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
  }) : super(
          uid: uid,
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          address: address,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "uid": uid,
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "address": address,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> doc) {
    return UserDataModel(
      uid: doc["uid"] as String,
      email: doc["email"] as String,
      password: doc["password"] as String,
      firstName: doc["firstName"] as String,
      lastName: doc["lastName"] as String,
      phone: doc["phone"] as String,
      address: doc["address"] as String,
    );
  }
}
