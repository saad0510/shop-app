import '../../domain/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required super.uid,
    required super.email,
    required super.password,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.address,
  });

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
