import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/shared/user/domain/repositories/user_repository.dart';
import 'package:shopping_app/shared/user/domain/usecases/save_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late final SaveUser usecase;
  late final MockUserRepository repo;
  late final UserData userData;

  setUpAll(() {
    userData = const UserData(
      uid: "1",
      email: "email",
      password: "password",
      firstName: "firstName",
      lastName: "lastName",
      phone: "phone",
      address: "address",
    );
    repo = MockUserRepository();
    usecase = SaveUser(repo);
    registerFallbackValue(userData);
  });

  test(
    'should save user to remote database',
    () async {
      // arrange
      when(() => repo.saveUser(any()))
          .thenAnswer((_) async => const Success(true));
      // act
      final result = await usecase(userData);
      // assert
      expect(result, const Success(true));
      verifyCalledOnce(() => repo.saveUser(userData));
      verifyNoMoreInteractions(repo);
    },
  );
}

void verifyCalledOnce(void Function() body) {
  verify(body).called(1);
}
