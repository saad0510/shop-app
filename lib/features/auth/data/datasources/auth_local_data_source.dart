import '../../../../core/entities/user_data.dart';

// TODO: return models, not entities

abstract class AuthLocalDataSource {
  /// stores the given userData in local cache
  ///
  /// throws a [CacheException] for all error codes
  Future<void> cacheUserData(UserData userData);

  /// retrives the last cached user data
  ///
  /// throws a [CacheException] for all error codes
  Future<UserData> getLastUserData();
}
