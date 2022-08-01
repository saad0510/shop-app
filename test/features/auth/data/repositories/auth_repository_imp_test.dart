import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/shared/user/data/models/user_data_model.dart';
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

  late String uid;
  late String email;
  late String password;
  late UserData userData;

  void fallbacks() {
    registerFallbackValue(userData);
    when(() => mockRemoteSrc.signin(any(), any())).thenAnswer((_) async => uid);
    when(() => mockRemoteSrc.signup(any(), any())).thenAnswer((_) async => uid);
    when(() => mockGetUser(any())).thenAnswer((_) async => Success(userData));
    when(() => mockSaveUser(any()))
        .thenAnswer((_) async => const Success(Void()));
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

    uid = "1";
    email = "acc1@fin.com";
    password = "test123";
    userData = const UserDataModel(
      uid: "1",
      email: "acc1@fin.com",
      password: "test123",
      firstName: "Saad",
      lastName: "Bin Khalid",
      phone: "+923133094567",
      address: "Landhi, Karachi, Pakistan",
    );
    fallbacks();
  });

  group("signin:", () {
    test(
      'should sigin user on success',
      () async {
        // arrange
        when(() => mockRemoteSrc.signin(any(), any()))
            .thenAnswer((_) async => uid);
        // act
        await repo.signin(email, password);
        // assert
        verify(() => mockRemoteSrc.signin(email, password)).called(1);
        verifyNoMoreInteractions(mockRemoteSrc);
      },
    );
    test(
      'should return remote UserData on success',
      () async {
        // arrange
        when(() => mockGetUser(any()))
            .thenAnswer((_) async => Success(userData));
        // act
        final result = await repo.signin(email, password);
        // assert
        expect(result, Success(userData));
        verify(() => mockGetUser(uid)).called(1);
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
        final result = await repo.signin(email, password);
        // assert
        expect(result, const Error(AuthFailure()));
        verify(() => mockRemoteSrc.signin(email, password)).called(1);
        verifyNoMoreInteractions(mockRemoteSrc);
      },
    );
  });

  group("signup:", () {
    test(
      'should signup user on success',
      () async {
        // arrange
        when(() => mockRemoteSrc.signup(any(), any()))
            .thenAnswer((_) async => uid);
        // act
        final userDataWithoutUid = userData.copyWith(uid: "");
        await repo.signup(userDataWithoutUid);
        // assert
        verify(() => mockRemoteSrc.signup(email, password)).called(1);
        verifyNoMoreInteractions(mockRemoteSrc);
      },
    );
    test(
      'should save UserData on database on success',
      () async {
        // arrange
        when(() => mockSaveUser(any()))
            .thenAnswer((_) async => const Success(Void()));
        // act
        final userDataWithoutUid = userData.copyWith(uid: "");
        final result = await repo.signup(userDataWithoutUid);
        // assert
        expect(result, Success(userData));
        verify(() => mockSaveUser(userData)).called(1);
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
        final result = await repo.signup(userData);
        // assert
        expect(result, const Error(AuthFailure()));
        verify(() => mockRemoteSrc.signup(email, password)).called(1);
        verifyNoMoreInteractions(mockRemoteSrc);
      },
    );
  });
}
