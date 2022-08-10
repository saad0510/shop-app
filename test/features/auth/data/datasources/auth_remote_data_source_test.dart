import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping_app/core/errors/exception.dart';
import 'package:shopping_app/features/auth/data/datasources/auth_remote_data_source.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockUser mockUser;
  late MockFirebaseAuth mockFireAuth;
  late MockUserCredential mockUserCredits;
  late AuthRemoteDataSourceImp datasource;

  const uid = "1";
  const email = "acc1@fin.com";
  const password = "test123";

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
    mockUser = MockUser();
    mockFireAuth = MockFirebaseAuth();
    mockUserCredits = MockUserCredential();
    datasource = AuthRemoteDataSourceImp(firebaseAuth: mockFireAuth);
    fallbacks();
  });

  void checkNullUser(Function() body) {
    when(() => mockUserCredits.user).thenReturn(null);
    expect(
      () => body(),
      throwsA(const TypeMatcher<AuthException>()),
    );
  }

  Future<void> checkSigninOrSignup(Future<String> Function() body) async {
    when(() => mockUser.uid).thenReturn(uid);
    final result = await body();
    expect(result, uid);
    verify(() => mockUser.uid).called(1);
  }

  group("signin", () {
    test(
      'should signin the user and return uid on success',
      () async {
        await checkSigninOrSignup(() => datasource.signin(email, password));
        verify(
          () => mockFireAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockFireAuth);
      },
    );
    test(
      'should throw AuthException if user is null',
      () {
        checkNullUser(() => datasource.signin(email, password));
      },
    );
  });

  group("signup", () {
    test(
      'should signup the user and return uid on success',
      () async {
        await checkSigninOrSignup(() => datasource.signup(email, password));
        verify(
          () => mockFireAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockFireAuth);
      },
    );
    test(
      'should throw AuthException if user is null',
      () async {
        checkNullUser(() => datasource.signup(email, password));
      },
    );
  });
}
