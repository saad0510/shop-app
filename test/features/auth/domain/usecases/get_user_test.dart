import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/features/auth/domain/entities/user_data.dart';
import 'package:shopping_app/features/auth/domain/repositories/user_repository.dart';
import 'package:shopping_app/features/auth/domain/usecases/get_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late final MockUserRepository mockRepo;
  late final GetUser usecase;

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
    usecase = GetUser(mockRepo);
    registerFallbackValue(user);
  });

  test(
    'should return remote user of given uid',
    () async {
      // arrange
      when(() => mockRepo.getUser(any()))
          .thenAnswer((_) async => const Success(user));
      // act
      final result = await usecase(user.uid);
      // assert
      expect(result, const Success(user));
      verify(() => mockRepo.getUser(user.uid)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
