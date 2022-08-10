import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/app/strings/error_strings.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/core/errors/failure.dart';
import 'package:shopping_app/core/network/network_info.dart';
import 'package:shopping_app/features/auth/data/datasources/user_local_data_source.dart';
import 'package:shopping_app/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:shopping_app/features/auth/data/models/user_data_model.dart';
import 'package:shopping_app/features/auth/data/repositories/user_repository_imp.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockUserRemoteDataSource mockRemoteSrc;
  late MockUserLocalDataSource mockLocalSrc;
  late MockNetworkInfo mockNetwork;
  late UserRepositoryImp repo;

  const user = UserDataModel(
    uid: "1",
    email: "email",
    password: "password",
    firstName: "firstName",
    lastName: "lastName",
    phone: "phone",
    address: "address",
  );

  void fallbacks() {
    registerFallbackValue(user);
    when(() => mockRemoteSrc.getUser(any())).thenAnswer((_) async => user);
    when(() => mockRemoteSrc.saveUser(any())).thenAnswer((_) async {});
    when(() => mockRemoteSrc.updateUser(any())).thenAnswer((_) async {});
    when(() => mockLocalSrc.cacheUserData(any())).thenAnswer((_) async {});
    when(() => mockLocalSrc.getLastUserData()).thenAnswer((_) async => user);
  }

  setUp(() {
    mockRemoteSrc = MockUserRemoteDataSource();
    mockLocalSrc = MockUserLocalDataSource();
    mockNetwork = MockNetworkInfo();
    repo = UserRepositoryImp(
      remoteDataSource: mockRemoteSrc,
      localDataSource: mockLocalSrc,
      networkInfo: mockNetwork,
    );
    fallbacks();
  });

  void runTestOnline(Function body) {
    group("device is online:", () {
      setUp(() {
        when(() => mockNetwork.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is offline:", () {
      setUp(() {
        when(() => mockNetwork.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  Future<void> checkCacheUser(Function body) async {
    when(() => mockLocalSrc.cacheUserData(any())).thenAnswer((_) async {});
    await body();
    verify(() => mockLocalSrc.cacheUserData(user)).called(1);
    verifyNoMoreInteractions(mockLocalSrc);
  }

  Future<void> checkCacheUserError(Function body) async {
    when(() => mockLocalSrc.cacheUserData(any()))
        .thenThrow(const CacheException());
    final result = await body();
    expect(result, const Error(CacheFailure()));
    verify(() => mockLocalSrc.cacheUserData(user)).called(1);
    verifyNoMoreInteractions(mockLocalSrc);
  }

  Future<void> checkGetCache(Function body) async {
    when(() => mockLocalSrc.getLastUserData()).thenAnswer((_) async => user);
    final result = await body();
    expect(result, const Success(user));
    verify(() => mockLocalSrc.getLastUserData()).called(1);
    verifyNoMoreInteractions(mockLocalSrc);
  }

  Future<void> checkGetCacheError(Function body) async {
    when(() => mockLocalSrc.getLastUserData())
        .thenThrow(const CacheException());
    final result = await body() as Result;
    expect(result.getError()!, const TypeMatcher<CacheFailure>());
    verify(() => mockLocalSrc.getLastUserData()).called(1);
    verifyNoMoreInteractions(mockLocalSrc);
  }

  void checkZeroInteraction(Function body) async {
    await body();
    verifyZeroInteractions(mockRemoteSrc);
    verifyZeroInteractions(mockLocalSrc);
  }

  runTestOnline(() {
    group("getUser:", () {
      test(
        'should retrieve user from remote database on success',
        () async {
          // arrange
          when(() => mockRemoteSrc.getUser(any()))
              .thenAnswer((_) async => user);
          // act
          final result = await repo.getUser(user.uid);
          // assert
          expect(result, const Success(user));
          verify(() => mockRemoteSrc.getUser(user.uid)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should cache user on local storage on success',
        () async {
          checkCacheUser(() => repo.getUser(user.uid));
        },
      );
      test(
        'should return DatabaseFailure on failure',
        () async {
          // arrange
          when(() => mockRemoteSrc.getUser(any()))
              .thenThrow(const DatabaseException());
          // act
          final result = await repo.getUser(user.uid);
          // assert
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockRemoteSrc.getUser(user.uid)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should return CacheFailure on failure',
        () async {
          checkCacheUserError(() => repo.getUser(user.uid));
        },
      );
    });
    group("saveUser:", () {
      test(
        'should save user on remote database on success',
        () async {
          // arrange
          when(() => mockRemoteSrc.saveUser(any()))
              .thenAnswer((_) async => success);
          // act
          final result = await repo.saveUser(user);
          // assert
          expect(result, const Success(success));
          verify(() => mockRemoteSrc.saveUser(user)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should save cache user on local storage on success',
        () async {
          checkCacheUser(() => repo.saveUser(user));
        },
      );
      test(
        'should return DatabaseFailure on failure',
        () async {
          // arrange
          when(() => mockRemoteSrc.saveUser(any()))
              .thenThrow(const DatabaseException());
          // act
          final result = await repo.saveUser(user);
          // assert
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockRemoteSrc.saveUser(user)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should return CacheFailure on failure',
        () async {
          checkCacheUserError(() => repo.saveUser(user));
        },
      );
    });
    group("updateUser:", () {
      test(
        'should update user with given data on remote database',
        () async {
          // arrange
          when(() => mockRemoteSrc.updateUser(any()))
              .thenAnswer((_) async => success);
          // act
          final result = await repo.updateUser(user);
          // assert
          expect(result, const Success(success));
          verify(() => mockRemoteSrc.updateUser(user)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should save cache user on local storage on success',
        () {
          checkCacheUser(() => repo.updateUser(user));
        },
      );
      test(
        'should return DatabaseFailure on failure',
        () async {
          // arrange
          when(() => mockRemoteSrc.updateUser(any()))
              .thenThrow(const DatabaseException());
          // act
          final result = await repo.updateUser(user);
          // assert
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockRemoteSrc.updateUser(user)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should return CacheFailure on failure',
        () async {
          checkCacheUserError(() => repo.updateUser(user));
        },
      );
    });
  });

  runTestOffline(() {
    group("getUser:", () {
      test(
        'should not interact with remoteDatasource at all',
        () async {
          // act & assert
          await repo.getUser(user.uid);
          verifyZeroInteractions(mockRemoteSrc);
        },
      );
      test(
        'should return locally cached user if id is same',
        () async {
          checkGetCache(() => repo.getUser(user.uid));
        },
      );
      test(
        'should return CacheFailure if id is different',
        () async {
          checkGetCacheError(() => repo.getUser("newId"));
        },
      );
      test(
        'should return CacheFailure on failure',
        () async {
          checkGetCacheError(() => repo.getUser(user.uid));
        },
      );
    });

    group("saveUser:", () {
      test(
        'should not interact with any data source at all',
        () async {
          checkZeroInteraction(() => repo.saveUser(user));
        },
      );
      test(
        'should always return DatabaseFailure',
        () async {
          // act & assert
          final result = await repo.saveUser(user);
          expect(
            result,
            const Error(DatabaseFailure(ErrorStrings.databaseNetwork)),
          );
        },
      );
    });
    group("updateUser:", () {
      test(
        'should not interact with any data source at all',
        () async {
          checkZeroInteraction(() => repo.updateUser(user));
        },
      );
      test(
        'should always return DatabaseFailure',
        () async {
          // act & assert
          final result = await repo.updateUser(user);
          expect(
            result,
            const Error(DatabaseFailure(ErrorStrings.databaseNetwork)),
          );
        },
      );
    });
  });
}
