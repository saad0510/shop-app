import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/shared/user/domain/repositories/user_repository.dart';
import 'package:shopping_app/shared/user/domain/usecases/get_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late final GetUser usecase;
  late final MockUserRepository repo;
  late final String uid;
  late final UserData userData;

  setUpAll(() {
    uid = "1";
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
    usecase = GetUser(repo);
    registerFallbackValue(userData);
  });

  test(
    'should return remote user of given uid',
    () async {
      // arrange
      when(() => repo.getUser(any()))
          .thenAnswer((_) async => Success(userData));
      // act
      final result = await usecase(uid);
      // assert
      expect(result, Success(userData));
      verify(() => repo.getUser(uid)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
