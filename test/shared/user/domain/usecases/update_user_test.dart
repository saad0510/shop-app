import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/shared/user/domain/repositories/user_repository.dart';
import 'package:shopping_app/shared/user/domain/usecases/update_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late final UpdateUser usecase;
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

  setUp(() {
    mockRepo = MockUserRepository();
    usecase = UpdateUser(mockRepo);
    registerFallbackValue(user);
  });

  test(
    'should update user with given data on remote database',
    () async {
      // arrange
      when(() => mockRepo.updateUser(any()))
          .thenAnswer((_) async => const Success(success));
      // act
      final result = await usecase(user);
      // assert
      expect(result, const Success(success));
      verify(() => mockRepo.updateUser(user)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
