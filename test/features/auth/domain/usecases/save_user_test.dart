import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/features/auth/domain/entities/user_data.dart';
import 'package:shopping_app/features/auth/domain/repositories/user_repository.dart';
import 'package:shopping_app/features/auth/domain/usecases/save_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late final SaveUser usecase;
  late final MockUserRepository mockRepo;

  const user = UserData(
    uid: "1",
    email: "email",
    password: "password",
    firstName: "firstName",
    lastName: "lastName",
    phone: "phone",
    address: "address",
  );

  setUpAll(() {
    mockRepo = MockUserRepository();
    usecase = SaveUser(mockRepo);
    registerFallbackValue(user);
  });

  test(
    'should save user to remote database',
    () async {
      // arrange
      when(() => mockRepo.saveUser(any()))
          .thenAnswer((_) async => const Success(success));
      // act
      final result = await usecase(user);
      // assert
      expect(result, const Success(success));
      verify(() => mockRepo.saveUser(user)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
