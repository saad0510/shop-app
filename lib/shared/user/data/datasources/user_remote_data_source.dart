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
