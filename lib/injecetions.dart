import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_imp.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/signin_user.dart';
import 'features/auth/domain/usecases/signout_user.dart';
import 'features/auth/domain/usecases/signup_user.dart';
import 'features/auth/presentation/controllers.dart';
import 'shared/user/data/datasources/user_local_data_source.dart';
import 'shared/user/data/datasources/user_remote_data_source.dart';
import 'shared/user/data/repositories/user_repository_imp.dart';
import 'shared/user/domain/repositories/user_repository.dart';
import 'shared/user/domain/usecases/get_user.dart';
import 'shared/user/domain/usecases/save_user.dart';
import 'shared/user/domain/usecases/update_user.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // FEATURES
  // - controllers
  locator.registerFactory(
    () => AuthUserNotifier(
      signinUsecase: locator(),
      signupUsecase: locator(),
      signoutUsecase: locator(),
      updateUsecase: locator(),
    ),
  );

  // - usecases
  locator.registerLazySingleton(() => SigninUser(locator()));
  locator.registerLazySingleton(() => SignupUser(locator()));
  locator.registerLazySingleton(() => SignoutUser(locator()));

  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => SaveUser(locator()));
  locator.registerLazySingleton(() => UpdateUser(locator()));

  // - repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      remoteDataSource: locator(),
      getUser: locator(),
      saveUser: locator(),
    ),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // - datasources
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImp(
      firebaseAuth: locator(),
    ),
  );
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImp(
      firestore: locator(),
    ),
  );
  locator.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImp(sharedPrefs: locator()),
  );

  // CORE
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(dataConnectionChecker: locator()),
  );

  // EXTERNAL
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => prefs);
  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
