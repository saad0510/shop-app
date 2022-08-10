import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/features/auth/domain/usecases/signout_user.dart';
import 'package:shopping_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late SignoutUser usecase;

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
    usecase = SignoutUser(mockRepo);
  });

  test(
    'should signout the user on success',
    () async {
      // arrange
      when(() => mockRepo.signout())
          .thenAnswer((_) async => const Success(success));
      // act
      final result = await usecase();
      // assert
      expect(result, const Success(success));
      verify(() => mockRepo.signout()).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
