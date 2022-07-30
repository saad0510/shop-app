import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/core/errors/failure.dart';
import 'package:shopping_app/core/network/network_info.dart';
import 'package:shopping_app/shared/user/data/datasources/user_local_data_source.dart';
import 'package:shopping_app/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';
import 'package:shopping_app/shared/user/data/repositories/user_repository_imp.dart';
import 'package:shopping_app/shared/user/domain/repositories/user_repository.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late UserRepositoryImp repo;
  late MockUserRemoteDataSource mockUserRemoteDataSrc;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockUserRemoteDataSrc = MockUserRemoteDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = UserRepositoryImp(
      remoteDataSource: mockUserRemoteDataSrc,
      localDataSource: mockUserLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
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
      late String uid;
      late UserDataModel userDataModel;

      setUp(() {
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
        registerFallbackValue(userDataModel);
      });

      test(
        'should retrieve and cache user from remote database on success',
        () async {
          // arrange
          when(() => mockUserRemoteDataSrc.getUser(any()))
              .thenAnswer((_) async => userDataModel);
          when(() => mockUserLocalDataSource.cacheUserData(any()))
              .thenAnswer((_) async {});
          // act
          final result = await repo.getUser(uid);
          // assert +ve
          expect(result, Success(userDataModel));
          verify(() => mockUserRemoteDataSrc.getUser(uid)).called(1);
          verify(() => mockUserLocalDataSource.cacheUserData(userDataModel))
              .called(1);
          // assert -ve
          verifyNoMoreInteractions(mockUserRemoteDataSrc);
          verifyNoMoreInteractions(mockUserLocalDataSource);
        },
      );
      test(
        'should throw DatabaseFailure on failure',
        () async {
          // arrange
          when(() => mockUserRemoteDataSrc.getUser(any()))
              .thenThrow(const DatabaseException());
          // act
          final result = await repo.getUser(uid);
          // assert +ve
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockUserRemoteDataSrc.getUser(uid)).called(1);
          // assert -ve
          verifyNoMoreInteractions(mockUserRemoteDataSrc);
          verifyZeroInteractions(mockUserLocalDataSource);
        },
      );
    });
    group("saveUser:", () {
      late UserDataModel userDataModel;

      setUp(() {
        userDataModel = const UserDataModel(
          uid: "1",
          email: "email",
          password: "password",
          firstName: "firstName",
          lastName: "lastName",
          phone: "phone",
          address: "address",
        );
        registerFallbackValue(userDataModel);
      });

      test(
        'should save and cache user on remote database on success',
        () async {
          // arrange
          when(() => mockUserRemoteDataSrc.saveUser(any()))
              .thenAnswer((_) async => const NoReturn());
          when(() => mockUserLocalDataSource.cacheUserData(any()))
              .thenAnswer((_) async {});
          // act
          final result = await repo.saveUser(userDataModel);
          // assert +ve
          expect(result, const Success(NoReturn()));
          verify(() => mockUserRemoteDataSrc.saveUser(userDataModel)).called(1);
          verify(() => mockUserLocalDataSource.cacheUserData(userDataModel))
              .called(1);
          // assert -ve
          verifyNoMoreInteractions(mockUserRemoteDataSrc);
          verifyNoMoreInteractions(mockUserLocalDataSource);
        },
      );
      test(
        'should throw DatabaseFailure on failure',
        () async {
          // arrange
          when(() => mockUserRemoteDataSrc.saveUser(any()))
              .thenThrow(const DatabaseException());
          // act
          final result = await repo.saveUser(userDataModel);
          // assert +ve
          expect(result, const Error(DatabaseFailure()));
          verify(() => mockUserRemoteDataSrc.saveUser(userDataModel)).called(1);
          // assert -ve
          verifyNoMoreInteractions(mockUserRemoteDataSrc);
          verifyZeroInteractions(mockUserLocalDataSource);
        },
      );
    });
  });

  runTestOffline(() {
    group("getUser:", () {
      late String uid;
      late UserDataModel userDataModel;

      setUp(() {
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
        registerFallbackValue(userDataModel);
      });

      test(
        'should return locally cached user if id is same',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getLastUserData())
              .thenAnswer((_) async => userDataModel);
          // act
          final result = await repo.getUser(uid);
          // assert +ve
          expect(result, Success(userDataModel));
          expect(uid, result.getSuccess()!.uid);
          verify(() => mockUserLocalDataSource.getLastUserData()).called(1);
          // assert -ve
          verifyNoMoreInteractions(mockUserLocalDataSource);
          verifyZeroInteractions(mockUserRemoteDataSrc);
        },
      );
      test(
        'should return CacheFailure if id is different',
        () async {
          const newUid = "2";
          // arrange
          when(() => mockUserLocalDataSource.getLastUserData())
              .thenAnswer((_) async => userDataModel);
          // act
          final result = await repo.getUser(newUid);
          // assert +ve
          expect(result, const Error(CacheFailure()));
          verify(() => mockUserLocalDataSource.getLastUserData()).called(1);
          // assert -ve
          verifyNoMoreInteractions(mockUserLocalDataSource);
          verifyZeroInteractions(mockUserRemoteDataSrc);
        },
      );
      test(
        'should throw CacheFailure on failure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getLastUserData())
              .thenThrow(const CacheException());
          // act
          final result = await repo.getUser(uid);
          // assert +ve
          expect(result, const Error(CacheFailure()));
          verify(() => mockUserLocalDataSource.getLastUserData()).called(1);
          // assert -ve
          verifyNoMoreInteractions(mockUserLocalDataSource);
          verifyZeroInteractions(mockUserRemoteDataSrc);
        },
      );
    });

    group("saveUser:", () {
      late UserDataModel userDataModel;

      setUp(() {
        userDataModel = const UserDataModel(
          uid: "1",
          email: "email",
          password: "password",
          firstName: "firstName",
          lastName: "lastName",
          phone: "phone",
          address: "address",
        );
        registerFallbackValue(userDataModel);
      });

      test(
        'should always throw DatabaseFailure',
        () async {
          // arrange
          // act
          final result = await repo.saveUser(userDataModel);
          // assert +ve
          expect(result, const Error(DatabaseFailure()));
          // assert -ve
          verifyZeroInteractions(mockUserRemoteDataSrc);
          verifyZeroInteractions(mockUserLocalDataSource);
        },
      );
    });
  });
}
