import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/core/entities/user_data.dart';
import 'package:shopping_app/features/auth/domain/entities/auth_user.dart';
import 'package:shopping_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:shopping_app/features/auth/domain/usecases/signup_user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepo;
  late SignupUser usecase;
  late AuthUser authUser;
  late UserData expectedUserData;

  setUp(() {
    authUser = const AuthUser(
      uid: "no-uid",
      email: "acc1@fin.com",
      password: "test123",
    );
    expectedUserData = UserData(
      uid: "1",
      email: "acc1@fin.com",
      password: "test123",
      firstName: "Saad",
      lastName: "Bin Khalid",
      phone: "+923133094567",
      address: "Landhi, Karachi, Pakistan",
    );
    mockAuthRepo = MockAuthRepository();
    usecase = SignupUser(mockAuthRepo);
    registerFallbackValue("");
  });

  test(
    'should register a new user and return user data from database',
    () async {
      // arrange
      when(() => mockAuthRepo.signup(any(), any()))
          .thenAnswer((_) async => Success(expectedUserData));

      // act
      final result = await usecase(authUser);

      // assert
      expect(result, Success(expectedUserData));
      verify(
        () => mockAuthRepo.signup(
          authUser.email,
          authUser.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepo);
    },
  );
}
