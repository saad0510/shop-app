import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:shopping_app/features/auth/domain/usecases/signup_user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late SignupUser usecase;

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
    usecase = SignupUser(mockRepo);
    registerFallbackValue(user);
  });

  test(
    'should register a new user and return user data from database',
    () async {
      // arrange
      when(() => mockRepo.signup(any()))
          .thenAnswer((_) async => const Success(user));
      // act
      final userDataWithoutUid = user.copyWith(uid: "");
      final result = await usecase(userDataWithoutUid);
      // assert
      expect(result, const Success(user));
      verify(() => mockRepo.signup(userDataWithoutUid)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
