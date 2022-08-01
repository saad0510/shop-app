import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/core/errors/failure.dart';
import 'package:shopping_app/core/network/network_info.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/shared/user/data/datasources/user_local_data_source.dart';
import 'package:shopping_app/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';
import 'package:shopping_app/shared/user/data/repositories/user_repository_imp.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late UserRepositoryImp repo;
  late MockUserRemoteDataSource mockRemoteSrc;
  late MockUserLocalDataSource mockLocalSrc;
  late MockNetworkInfo mockNetworkInfo;

  late String uid;
  late UserDataModel userDataModel;

  void fallbacks() {
    registerFallbackValue(userDataModel);
    when(() => mockRemoteSrc.getUser(any()))
        .thenAnswer((_) async => userDataModel);
    when(() => mockRemoteSrc.saveUser(any())).thenAnswer((_) async {});
    when(() => mockLocalSrc.cacheUserData(any())).thenAnswer((_) async {});
    when(() => mockLocalSrc.getLastUserData())
        .thenAnswer((_) async => userDataModel);
  }

  setUp(() {
    mockRemoteSrc = MockUserRemoteDataSource();
    mockLocalSrc = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = UserRepositoryImp(
      remoteDataSource: mockRemoteSrc,
      localDataSource: mockLocalSrc,
      networkInfo: mockNetworkInfo,
    );

    uid = "1";
    userDataModel = const UserDataModel(
      uid: "1",
      email: "email",
      password: "password",
      firstName: "firstName",
      lastName: "lastName",
      phone: "phone",
      address: "address",
    );
    fallbacks();
  });

  void runTestOnline(Function body) {
    group("device is online:", () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is offline:", () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestOnline(() {
    group("getUser:", () {
      test(
        'should retrieve user from remote database on success',
        () async {
          // arrange
          when(() => mockRemoteSrc.getUser(any()))
              .thenAnswer((_) async => userDataModel);
          // act
          final result = await repo.getUser(uid);
          // assert
          expect(result, Success(userDataModel));
          verify(() => mockRemoteSrc.getUser(uid)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should cache user on local storage on success',
        () async {
          // arrange
          when(() => mockLocalSrc.cacheUserData(any()))
              .thenAnswer((_) async {});
          // act
          await repo.getUser(uid);
          // assert
          verify(() => mockLocalSrc.cacheUserData(userDataModel)).called(1);
          verifyNoMoreInteractions(mockLocalSrc);
        },
      );
      test(
        'should return DatabaseFailure on failure',
        () async {
          // arrange
          when(() => mockRemoteSrc.getUser(any()))
              .thenThrow(const DatabaseException());
          // act
          final result = await repo.getUser(uid);
          // assert
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockRemoteSrc.getUser(uid)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should return CacheFailure on failure',
        () async {
          // arrange
          when(() => mockLocalSrc.cacheUserData(any()))
              .thenThrow(const CacheException());
          // act
          final result = await repo.getUser(uid);
          // assert
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockLocalSrc.cacheUserData(userDataModel)).called(1);
          verifyNoMoreInteractions(mockLocalSrc);
        },
      );
    });
    group("saveUser:", () {
      test(
        'should save user on remote database on success',
        () async {
          // arrange
          when(() => mockRemoteSrc.saveUser(any()))
              .thenAnswer((_) async => const Void());
          // act
          final result = await repo.saveUser(userDataModel);
          // assert
          expect(result, const Success(Void()));
          verify(() => mockRemoteSrc.saveUser(userDataModel)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should save cache user on local storage on success',
        () async {
          // arrange
          when(() => mockLocalSrc.cacheUserData(any()))
              .thenAnswer((_) async {});
          // act
          await repo.saveUser(userDataModel);
          // assert
          verify(() => mockLocalSrc.cacheUserData(userDataModel)).called(1);
          verifyNoMoreInteractions(mockLocalSrc);
        },
      );
      test(
        'should throw DatabaseFailure on failure',
        () async {
          // arrange
          when(() => mockRemoteSrc.saveUser(any()))
              .thenThrow(const DatabaseException());
          // act
          final result = await repo.saveUser(userDataModel);
          // assert
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockRemoteSrc.saveUser(userDataModel)).called(1);
          verifyNoMoreInteractions(mockRemoteSrc);
        },
      );
      test(
        'should return CacheFailure on failure',
        () async {
          // arrange
          when(() => mockLocalSrc.cacheUserData(any()))
              .thenThrow(const CacheException());
          // act
          final result = await repo.saveUser(userDataModel);
          // assert
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockLocalSrc.cacheUserData(userDataModel)).called(1);
          verifyNoMoreInteractions(mockLocalSrc);
        },
      );
    });
  });

  runTestOffline(() {
    group("getUser:", () {
      test(
        'should not interact with remoteDatasource at all',
        () async {
          // act
          await repo.getUser(uid);
          // assert
          verifyZeroInteractions(mockRemoteSrc);
        },
      );
      test(
        'should return locally cached user if id is same',
        () async {
          // arrange
          when(() => mockLocalSrc.getLastUserData())
              .thenAnswer((_) async => userDataModel);
          // act
          final result = await repo.getUser(uid);
          // assert
          expect(result, Success(userDataModel));
          expect(result.getSuccess()!.uid, uid);
          verify(() => mockLocalSrc.getLastUserData()).called(1);
          verifyNoMoreInteractions(mockLocalSrc);
        },
      );
      test(
        'should return CacheFailure if id is different',
        () async {
          const newUid = "2";
          // arrange
          when(() => mockLocalSrc.getLastUserData())
              .thenAnswer((_) async => userDataModel);
          // act
          final result = await repo.getUser(newUid);
          // assert
          expect(result, const Error(CacheFailure()));
          verify(() => mockLocalSrc.getLastUserData()).called(1);
          verifyNoMoreInteractions(mockLocalSrc);
        },
      );
      test(
        'should return CacheFailure on failure',
        () async {
          // arrange
          when(() => mockLocalSrc.getLastUserData())
              .thenThrow(const CacheException());
          // act
          final result = await repo.getUser(uid);
          // assert
          expect(result, const Error(CacheFailure()));
          verify(() => mockLocalSrc.getLastUserData()).called(1);
          verifyNoMoreInteractions(mockLocalSrc);
        },
      );
    });

    group("saveUser:", () {
      test(
        'should not interact with any data source at all',
        () async {
          // act
          await repo.saveUser(userDataModel);
          // assert
          verifyZeroInteractions(mockRemoteSrc);
          verifyZeroInteractions(mockLocalSrc);
        },
      );
      test(
        'should always return DatabaseFailure',
        () async {
          // act
          final result = await repo.saveUser(userDataModel);
          // assert
          expect(result, const Error(DatabaseFailure()));
        },
      );
    });
  });
}
