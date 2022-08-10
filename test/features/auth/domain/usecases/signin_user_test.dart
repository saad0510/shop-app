import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:shopping_app/features/auth/domain/usecases/signin_user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late SigninUser usecase;

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
    mockRepo = MockAuthRepository();
    usecase = SigninUser(mockRepo);
  });

  test(
    'should signin the user and return user data from database',
    () async {
      // arrange
      when(() => mockRepo.signin(any(), any()))
          .thenAnswer((_) async => const Success(user));
      // act
      final result = await usecase(SigninParams(user.email, user.password));
      // assert
      expect(result, const Success(user));
      verify(() => mockRepo.signin(user.email, user.password)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
