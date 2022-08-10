import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/core/errors/failure.dart';
import 'package:shopping_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shopping_app/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/shared/user/domain/usecases/get_user.dart';
import 'package:shopping_app/shared/user/domain/usecases/save_user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockGetUser extends Mock implements GetUser {}

class MockSaveUser extends Mock implements SaveUser {}

void main() {
  late MockAuthRemoteDataSource mockRemoteSrc;
  late MockGetUser mockGetUser;
  late MockSaveUser mockSaveUser;
  late AuthRepositoryImp repo;

  const user = UserData(
    uid: "1",
    email: "acc1@fin.com",
    password: "test123",
    firstName: "Saad",
    lastName: "Bin Khalid",
    phone: "+923133094567",
    address: "Landhi, Karachi, Pakistan",
  );

  void fallbacks() {
    registerFallbackValue(user);
    when(() => mockRemoteSrc.signin(any(), any()))
        .thenAnswer((_) async => user.uid);
    when(() => mockRemoteSrc.signup(any(), any()))
        .thenAnswer((_) async => user.uid);

    when(() => mockGetUser(any())).thenAnswer((_) async => const Success(user));
    when(() => mockSaveUser(any()))
        .thenAnswer((_) async => const Success(success));
  }

  setUp(() {
    mockRemoteSrc = MockAuthRemoteDataSource();
    mockGetUser = MockGetUser();
    mockSaveUser = MockSaveUser();
    repo = AuthRepositoryImp(
      remoteDataSource: mockRemoteSrc,
      getUser: mockGetUser,
      saveUser: mockSaveUser,
    );
    fallbacks();
  });

  Future<Result<Failure, UserData>> checkSignin() async {
    final result = await repo.signin(user.email, user.password);
    verify(() => mockRemoteSrc.signin(user.email, user.password)).called(1);
    verifyNoMoreInteractions(mockRemoteSrc);
    return result;
  }

  Future<Result<Failure, UserData>> checkSignup() async {
    final userDataWithoutUid = user.copyWith(uid: "");
    final result = await repo.signup(userDataWithoutUid);
    verify(() => mockRemoteSrc.signup(user.email, user.password)).called(1);
    verifyNoMoreInteractions(mockRemoteSrc);
    return result;
  }

  group("signin:", () {
    test(
      'should sigin user on success',
      () async {
        // arrange
        when(() => mockRemoteSrc.signin(any(), any()))
            .thenAnswer((_) async => user.uid);
        // act & assert
        await checkSignin();
      },
    );
    test(
      'should return remote UserData on success',
      () async {
        // arrange
        when(() => mockGetUser(any()))
            .thenAnswer((_) async => const Success(user));
        // act
        final result = await repo.signin(user.email, user.password);
        // assert
        expect(result, const Success(user));
        verify(() => mockGetUser(user.uid)).called(1);
        verifyNoMoreInteractions(mockGetUser);
      },
    );
    test(
      'should return AuthFailure on failure',
      () async {
        // arrange
        when(() => mockRemoteSrc.signin(any(), any()))
            .thenThrow(const AuthException());
        // act
        final result = await checkSignin();
        // assert
        expect(result, const Error(AuthFailure()));
      },
    );
  });

  group("signup:", () {
    test(
      'should signup user on success',
      () async {
        // arrange
        when(() => mockRemoteSrc.signup(any(), any()))
            .thenAnswer((_) async => user.uid);
        // act & assert
        await checkSignup();
      },
    );
    test(
      'should save UserData on database on success',
      () async {
        // arrange
        when(() => mockSaveUser(any()))
            .thenAnswer((_) async => const Success(success));
        // act
        final userDataWithoutUid = user.copyWith(uid: "");
        final result = await repo.signup(userDataWithoutUid);
        // assert
        expect(result, const Success(user));
        verify(() => mockSaveUser(user)).called(1);
        verifyNoMoreInteractions(mockSaveUser);
      },
    );
    test(
      'should return AuthFailure on failure',
      () async {
        // arrange
        when(() => mockRemoteSrc.signup(any(), any()))
            .thenThrow(const AuthException());
        // act
        final result = await checkSignup();
        // assert
        expect(result, const Error(AuthFailure()));
      },
    );
  });
  group("signout:", () {
    test(
      'should signout user on success',
      () async {
        // arrange
        when(() => mockRemoteSrc.signout()).thenAnswer((_) async => user.uid);
        // act
        final result = await repo.signout();
        expect(result, const Success(success));
        verify(() => mockRemoteSrc.signout()).called(1);
        verifyNoMoreInteractions(mockRemoteSrc);
      },
    );
    test(
      'should return AuthFailure on failure',
      () async {
        // arrange
        when(() => mockRemoteSrc.signout()).thenThrow(const AuthException());
        // act
        final result = await repo.signout();
        // assert
        expect(result, const Error(AuthFailure()));
      },
    );
  });
}
