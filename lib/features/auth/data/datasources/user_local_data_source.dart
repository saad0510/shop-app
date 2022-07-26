import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/strings/error_strings.dart';
import '../../../../core/errors/exception.dart';
import '../models/user_data_model.dart';

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

class UserLocalDataSourceImp extends UserLocalDataSource {
  final SharedPreferences sharedPrefs;
  static const USER_DATA_KEY = "USER_DATA_KEY";

  UserLocalDataSourceImp({required this.sharedPrefs});

  @override
  Future<void> cacheUserData(UserDataModel userData) async {
    bool success = await sharedPrefs.setString(
      USER_DATA_KEY,
      jsonEncode(userData.toMap()),
    );
    if (success == false) {
      throw const CacheException(ErrorStrings.cacheSavingFailed);
    }
  }

  @override
  Future<UserDataModel> getLastUserData() async {
    final json = sharedPrefs.getString(USER_DATA_KEY);
    if (json != null) {
      return UserDataModel.fromMap(jsonDecode(json));
    }
    throw const CacheException(ErrorStrings.cacheNoUser);
  }
}
