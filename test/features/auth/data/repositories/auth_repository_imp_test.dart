import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/core/errors/failure.dart';
import 'package:shopping_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shopping_app/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:shopping_app/features/auth/domain/entities/auth_user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSrc;
  late AuthRepositoryImp repo;

  setUp(() {
    mockAuthRemoteDataSrc = MockAuthRemoteDataSource();
    repo = AuthRepositoryImp(
      remoteDataSource: mockAuthRemoteDataSrc,
    );
  });

  group("signin:", () {
    late AuthUser authUser;
    late UserDataModel userData;

    setUp(() {
      authUser = const AuthUser(
        uid: "no-uid",
        email: "acc1@fin.com",
        password: "test123",
      );
      userData = const UserDataModel(
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

    test(
      'should sigin and return remote UserData on success',
      () async {
        // arrange
        when(() => mockAuthRemoteDataSrc.signin(any(), any()))
            .thenAnswer((_) async => userData);
        // act
        final result = await repo.signin(authUser);
        // assert +ve
        expect(result, Success(userData));
        verifyCalledOnce(
          () => mockAuthRemoteDataSrc.signin(authUser.email, authUser.password),
        );
        // assert -ve
        verifyNoMoreInteractions(mockAuthRemoteDataSrc);
      },
    );
    test(
      'should return AuthFailure on failure',
      () async {
        // arrange
        when(() => mockAuthRemoteDataSrc.signin(any(), any()))
            .thenThrow(const AuthException());
        // act
        final result = await repo.signin(authUser);
        // assert
        expect(result, const Error(AuthFailure()));
        verifyCalledOnce(
          () => mockAuthRemoteDataSrc.signin(authUser.email, authUser.password),
        );
        // assert -ve
        verifyNoMoreInteractions(mockAuthRemoteDataSrc);
      },
    );
  });

  group("signup:", () {
    late AuthUser authUser;
    late UserDataModel userData;

    setUp(() {
      authUser = const AuthUser(
        uid: "no-uid",
        email: "acc1@fin.com",
        password: "test123",
      );
      userData = const UserDataModel(
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

    test(
      'should signup and return remote UserData on success',
      () async {
        // arrange
        when(() => mockAuthRemoteDataSrc.signup(any(), any()))
            .thenAnswer((_) async => userData);
        // act
        final result = await repo.signup(authUser);
        // assert +ve
        expect(result, Success(userData));
        verifyCalledOnce(
          () => mockAuthRemoteDataSrc.signup(authUser.email, authUser.password),
        );
        // assert -ve
        verifyNoMoreInteractions(mockAuthRemoteDataSrc);
      },
    );
    test(
      'should return AuthFailure on failure',
      () async {
        // arrange
        when(() => mockAuthRemoteDataSrc.signup(any(), any()))
            .thenThrow(const AuthException());
        // act
        final result = await repo.signup(authUser);
        // assert
        expect(result, const Error(AuthFailure()));
        verifyCalledOnce(
          () => mockAuthRemoteDataSrc.signup(authUser.email, authUser.password),
        );
        // assert -ve
        verifyNoMoreInteractions(mockAuthRemoteDataSrc);
      },
    );
  });
}

verifyCalledOnce(Function function) {
  verify(() => function()).called(1);
}
