import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/features/auth/data/datasources/auth_remote_data_source.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockFireAuth;
  late MockUserCredential mockUserCredits;
  late MockUser mockUser;
  late AuthRemoteDataSourceImp datasource;

  late String uid;
  late String email;
  late String password;

  void fallbacks() {
    when(() => mockFireAuth.signInWithEmailAndPassword(
          email: any(named: "email"),
          password: any(named: "password"),
        )).thenAnswer((_) async => mockUserCredits);
    when(() => mockFireAuth.createUserWithEmailAndPassword(
          email: any(named: "email"),
          password: any(named: "password"),
        )).thenAnswer((_) async => mockUserCredits);
    when(() => mockUserCredits.user).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(uid);
  }

  setUp(() {
    mockFireAuth = MockFirebaseAuth();
    mockUserCredits = MockUserCredential();
    mockUser = MockUser();
    datasource = AuthRemoteDataSourceImp(firebaseAuth: mockFireAuth);

    uid = "1";
    email = "acc1@fin.com";
    password = "test123";
    fallbacks();
  });

  group("signin", () {
    test(
      'should signin the user and return uid on success',
      () async {
        // arrange
        when(() => mockUser.uid).thenReturn(uid);
        // act
        final result = await datasource.signin(email, password);
        // assert
        expect(result, uid);
        verify(() => mockFireAuth.signInWithEmailAndPassword(
              email: email,
              password: password,
            )).called(1);
        verify(() => mockUser.uid).called(1);
        verifyNoMoreInteractions(mockFireAuth);
      },
    );
    test(
      'should throw AuthException if user is null',
      () async {
        // arrange
        when(() => mockUserCredits.user).thenReturn(null);
        // act & assert
        expect(
          () => datasource.signin(email, password),
          throwsA(const TypeMatcher<AuthException>()),
        );
      },
    );
  });

  group("signup", () {
    test(
      'should signup the user and return uid on success',
      () async {
        // arrange
        when(() => mockUser.uid).thenReturn(uid);
        // act
        final result = await datasource.signup(email, password);
        // assert
        expect(result, uid);
        verify(() => mockFireAuth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            )).called(1);
        verify(() => mockUser.uid).called(1);
        verifyNoMoreInteractions(mockFireAuth);
      },
    );
    test(
      'should throw AuthException if user is null',
      () async {
        // arrange
        when(() => mockUserCredits.user).thenReturn(null);
        // act & assert
        expect(
          () => datasource.signup(email, password),
          throwsA(const TypeMatcher<AuthException>()),
        );
      },
    );
  });
}
