import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/core/errors/exception.dart';

import '../models/user_data_model.dart';

abstract class UserRemoteDataSource {
  /// fetches a user with given uid from database
  ///
  /// throws [DatabaseException] on all errors
  Future<UserDataModel> getUser(String uid);

  /// stores the given user on remote database, if new
  ///
  /// throws [DatabaseException] on all errors
  Future<void> saveUser(UserDataModel userData);
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  final FirebaseFirestore firestore;
  static const USERS_COLLECTION = "/users";

  UserRemoteDataSourceImp({required this.firestore});

  @override
  Future<UserDataModel> getUser(String uid) async {
    final docSnap = await firestore.collection(USERS_COLLECTION).doc(uid).get();
    final docData = docSnap.data();
    if (docData != null) {
      return UserDataModel.fromMap(docData);
    }
    throw DatabaseException("document for user '$uid' not found");
  }

  @override
  Future<void> saveUser(UserDataModel userData) async {
    await firestore.collection(USERS_COLLECTION).add(userData.toMap());
  }
}
