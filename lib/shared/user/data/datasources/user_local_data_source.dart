import '../../../../shared/user/data/models/user_data_model.dart';

abstract class UserLocalDataSource {
  /// stores the given UserData in local cache
  ///
  /// throws a [CacheException] for all error codes
  Future<void> cacheUserData(UserDataModel userData);

  /// retrives the last cached UserData
  ///
  /// throws a [CacheException] for all error codes
  Future<UserDataModel> getLastUserData();
}
