import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/core/errors/failure.dart';
import 'package:shopping_app/core/platform/network_info.dart';
import 'package:shopping_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:shopping_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shopping_app/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:shopping_app/features/auth/domain/entities/auth_user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late final MockAuthRemoteDataSource mockAuthRemoteDataSrc;
  late final MockAuthLocalDataSource mockAuthLocalDataSrc;
  late final MockNetworkInfo mockNetworkInfo;
  late final AuthRepositoryImp repo;

  setUpAll(() {
    mockAuthRemoteDataSrc = MockAuthRemoteDataSource();
    mockAuthLocalDataSrc = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = AuthRepositoryImp(
      remoteDataSource: mockAuthRemoteDataSrc,
      localDataSource: mockAuthLocalDataSrc,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("signin:", () {
    late final AuthUser authUser;
    late final UserData userData;

    setUpAll(() {
      authUser = const AuthUser(
        uid: "no-uid",
        email: "acc1@fin.com",
        password: "test123",
      );
      userData = const UserData(
        uid: "1",
        email: "acc1@fin.com",
        password: "test123",
        firstName: "Saad",
        lastName: "Bin Khalid",
        phone: "+923133094567",
        address: "Landhi, Karachi, Pakistan",
      );

      registerFallbackValue(authUser);
      registerFallbackValue(userData);
    });

    runTestOnline(() {
      test(
        'should return and cache remote UserData when call is successful',
        () async {
          // arrange
          when(() => mockAuthRemoteDataSrc.signin(any(), any()))
              .thenAnswer((_) async => userData);
          when(() => mockAuthLocalDataSrc.cacheUserData(any()))
              .thenAnswer((_) async {});
          // act
          final result = await repo.signin(authUser.email, authUser.password);
          // assert +ve
          expect(result, Success(userData));
          verifyCalledOnce(
            () =>
                mockAuthRemoteDataSrc.signin(authUser.email, authUser.password),
          );
          verifyCalledOnce(() => mockAuthLocalDataSrc.cacheUserData(userData));
          // assert -ve
          verifyNever(() => mockAuthLocalDataSrc.getLastUserData());
          verifyNoMoreInteractions(mockAuthRemoteDataSrc);
          verifyNoMoreInteractions(mockAuthLocalDataSrc);
        },
      );
      test(
        'should return AuthFailure when call is unsuccessful',
        () async {
          // arrange
          when(() => mockAuthRemoteDataSrc.signin(any(), any()))
              .thenThrow(const AuthException());
          // act
          final result = await repo.signin(authUser.email, authUser.password);
          // assert
          expect(result, const Error(AuthFailure()));
          verifyCalledOnce(
            () =>
                mockAuthRemoteDataSrc.signin(authUser.email, authUser.password),
          );
          // assert -ve
          verifyNoMoreInteractions(mockAuthRemoteDataSrc);
          verifyZeroInteractions(mockAuthLocalDataSrc);
        },
      );
    });

    runTestOffline(() {
      test(
        'should return the locally cached UserData when cache is present',
        () async {
          // arrange
          when(() => mockAuthLocalDataSrc.getLastUserData())
              .thenAnswer((_) async => userData);
          // act
          final result = await repo.signin(authUser.email, authUser.password);
          // assert +ve
          expect(result, Success(userData));
          verifyCalledOnce(() => mockAuthLocalDataSrc.getLastUserData());
          // assert -ve
          verifyNoMoreInteractions(mockAuthLocalDataSrc);
          verifyZeroInteractions(mockAuthRemoteDataSrc);
        },
      );
      test(
        'should return CacheFailure when cache is absent',
        () async {
          // arrange
          when(() => mockAuthLocalDataSrc.getLastUserData())
              .thenThrow(const CacheException());
          // act
          final result = await repo.signin(authUser.email, authUser.password);
          // assert +ve
          expect(result, const Error(CacheFailure()));
          verifyCalledOnce(() => mockAuthLocalDataSrc.getLastUserData());
          // assert -ve
          verifyNoMoreInteractions(mockAuthLocalDataSrc);
          verifyZeroInteractions(mockAuthRemoteDataSrc);
        },
      );
    });
  });

  group("signup:", () {
    late final AuthUser authUser;
    late final UserData userData;

    setUpAll(() {
      authUser = const AuthUser(
        uid: "no-uid",
        email: "acc1@fin.com",
        password: "test123",
      );
      userData = const UserData(
        uid: "1",
        email: "acc1@fin.com",
        password: "test123",
        firstName: "Saad",
        lastName: "Bin Khalid",
        phone: "+923133094567",
        address: "Landhi, Karachi, Pakistan",
      );

      registerFallbackValue(authUser);
      registerFallbackValue(userData);
    });

    runTestOnline(() {
      test(
        'should return and cache remote UserData when call is successful',
        () async {
          // arrange
          when(() => mockAuthRemoteDataSrc.signup(any(), any()))
              .thenAnswer((_) async => userData);
          when(() => mockAuthLocalDataSrc.cacheUserData(any()))
              .thenAnswer((_) async {});
          // act
          final result = await repo.signup(authUser.email, authUser.password);
          // assert +ve
          expect(result, Success(userData));
          verifyCalledOnce(
            () =>
                mockAuthRemoteDataSrc.signup(authUser.email, authUser.password),
          );
          verifyCalledOnce(() => mockAuthLocalDataSrc.cacheUserData(userData));
          // assert -ve
          verifyNever(() => mockAuthLocalDataSrc.getLastUserData());
          verifyNoMoreInteractions(mockAuthRemoteDataSrc);
          verifyNoMoreInteractions(mockAuthLocalDataSrc);
        },
      );
      test(
        'should return AuthFailure when call is unsuccessful',
        () async {
          // arrange
          when(() => mockAuthRemoteDataSrc.signup(any(), any()))
              .thenThrow(const AuthException());
          // act
          final result = await repo.signup(authUser.email, authUser.password);
          // assert
          expect(result, const Error(AuthFailure()));
          verifyCalledOnce(
            () =>
                mockAuthRemoteDataSrc.signup(authUser.email, authUser.password),
          );
          // assert -ve
          verifyNoMoreInteractions(mockAuthRemoteDataSrc);
          verifyZeroInteractions(mockAuthLocalDataSrc);
        },
      );
    });

    runTestOffline(() {
      test(
        'should return the locally cached UserData when cache is present',
        () async {
          // arrange
          when(() => mockAuthLocalDataSrc.getLastUserData())
              .thenAnswer((_) async => userData);
          // act
          final result = await repo.signup(authUser.email, authUser.password);
          // assert +ve
          expect(result, Success(userData));
          verifyCalledOnce(() => mockAuthLocalDataSrc.getLastUserData());
          // assert -ve
          verifyNoMoreInteractions(mockAuthLocalDataSrc);
          verifyZeroInteractions(mockAuthRemoteDataSrc);
        },
      );
      test(
        'should return CacheFailure when cache is absent',
        () async {
          // arrange
          when(() => mockAuthLocalDataSrc.getLastUserData())
              .thenThrow(const CacheException());
          // act
          final result = await repo.signup(authUser.email, authUser.password);
          // assert +ve
          expect(result, const Error(CacheFailure()));
          verifyCalledOnce(() => mockAuthLocalDataSrc.getLastUserData());
          // assert -ve
          verifyNoMoreInteractions(mockAuthLocalDataSrc);
          verifyZeroInteractions(mockAuthRemoteDataSrc);
        },
      );
    });
  });
}

verifyCalledOnce(Function function) {
  verify(() => function()).called(1);
}
