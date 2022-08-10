import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/core/errors/failure.dart';
import 'package:shopping_app/features/auth/domain/usecases/signin_user.dart';
import 'package:shopping_app/features/auth/domain/usecases/signout_user.dart';
import 'package:shopping_app/features/auth/domain/usecases/signup_user.dart';
import 'package:shopping_app/features/auth/presentation/controllers/auth_user_provider.dart';
import 'package:shopping_app/features/auth/presentation/controllers/auth_user_state.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/shared/user/domain/usecases/update_user.dart';

class MockSigninUser extends Mock implements SigninUser {}

class MockSignupUser extends Mock implements SignupUser {}

class MockSignoutUser extends Mock implements SignoutUser {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late MockSigninUser mockSigninUser;
  late MockSignupUser mockSignupUser;
  late MockSignoutUser mockSignoutUser;
  late MockUpdateUser mockUpdateUser;
  late AuthUserNotifier provider;

  const user = UserData(
    uid: "1",
    email: "acc1@fin.com",
    password: "test123",
    firstName: "Saad",
    lastName: "Bin Khalid",
    phone: "+923133094567",
    address: "Landhi, Karachi, Pakistan",
  );

  setUp(() {
    mockSigninUser = MockSigninUser();
    mockSignupUser = MockSignupUser();
    mockSignoutUser = MockSignoutUser();
    mockUpdateUser = MockUpdateUser();
    provider = AuthUserNotifier(
      signinUsecase: mockSigninUser,
      signupUsecase: mockSignupUser,
      signoutUsecase: mockSignoutUser,
      updateUsecase: mockUpdateUser,
    );
    registerFallbackValue(const SigninParams("", ""));
    registerFallbackValue(user);
  });

  test(
    'should emit initial state as AuthUserEmpty',
    () async {
      expect(provider.debugState, const TypeMatcher<AuthUserEmpty>());
    },
  );
  group("SigninUser", () {
    test(
      'should emit AuthUserLoaded on success',
      () async {
        // arrange
        when(() => mockSigninUser(any()))
            .thenAnswer((_) async => const Success(user));
        // assert later
        expect(
          provider.stream,
          emitsInOrder([
            const TypeMatcher<AuthUserLoading>(),
            AuthUserLoaded(userData: user),
          ]),
        );
        // act
        provider.signin(user.email, user.password);
        await untilCalled(() => mockSigninUser(any()));
        // assert
        verify(() => mockSigninUser(SigninParams(user.email, user.password)))
            .called(1);
      },
    );
    test(
      'should emit AuthUserError on failure',
      () async {
        // arrange
        when(() => mockSigninUser.call(any()))
            .thenAnswer((invocation) async => const Error(AuthFailure("")));
        // assert later
        expect(
          provider.stream,
          emitsInOrder([
            const TypeMatcher<AuthUserLoading>(),
            AuthUserError(message: ""),
          ]),
        );
        // act
        provider.signin(user.email, user.password);
        await untilCalled(() => mockSigninUser(any()));
      },
    );
  });
  group("SignupUser", () {
    test(
      'should emit AuthUserLoaded on success',
      () async {
        // arrange
        when(() => mockSignupUser.call(any()))
            .thenAnswer((invocation) async => const Success(user));
        // assert later
        expect(
          provider.stream,
          emitsInOrder([
            const TypeMatcher<AuthUserLoading>(),
            AuthUserLoaded(userData: user),
          ]),
        );
        // act
        provider.signup(user.copyWith(uid: ""));
        await untilCalled(() => mockSignupUser(any()));
        // assert
        verify(() => mockSignupUser(user.copyWith(uid: ""))).called(1);
      },
    );
    test(
      'should emit AuthUserError on failure',
      () async {
        // arrange
        when(() => mockSignupUser.call(any()))
            .thenAnswer((invocation) async => const Error(AuthFailure("")));
        // assert later
        expect(
          provider.stream,
          emitsInOrder([
            const TypeMatcher<AuthUserLoading>(),
            AuthUserError(message: ""),
          ]),
        );
        // act
        provider.signup(user);
        await untilCalled(() => mockSignupUser(any()));
      },
    );
  });
  group("SignoutUser", () {
    test(
      'should emit AuthUserEmpty on success',
      () async {
        // arrange
        when(() => mockSignoutUser.call())
            .thenAnswer((invocation) async => const Success(success));
        // assert later
        expect(
          provider.stream,
          emitsInOrder([
            const TypeMatcher<AuthUserLoading>(),
            const TypeMatcher<AuthUserEmpty>(),
          ]),
        );
        // act
        provider.signout();
        await untilCalled(() => mockSignoutUser());
        // assert
        verify(() => mockSignoutUser()).called(1);
      },
    );
    test(
      'should emit AuthUserError on failure',
      () async {
        // arrange
        when(() => mockSignoutUser.call())
            .thenAnswer((invocation) async => const Error(AuthFailure()));
        // assert later
        expect(
          provider.stream,
          emitsInOrder([
            const TypeMatcher<AuthUserLoading>(),
            AuthUserError(message: ""),
          ]),
        );
        // act
        provider.signout();
        await untilCalled(() => mockSignoutUser());
        // assert
        verify(() => mockSignoutUser()).called(1);
      },
    );
  });
}
