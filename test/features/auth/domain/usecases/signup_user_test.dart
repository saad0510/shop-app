import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shopping_app/shared/user/domain/entities/user_data.dart';
import 'package:shopping_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:shopping_app/features/auth/domain/usecases/signup_user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepo;
  late SignupUser usecase;

  late UserData userData;

  setUp(() {
    userData = const UserData(
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
    registerFallbackValue(userData);
  });

  test(
    'should register a new user and return user data from database',
    () async {
      // arrange
      when(() => mockAuthRepo.signup(any()))
          .thenAnswer((_) async => Success(userData));
      // act
      final userDataWithoutUid = userData.copyWith(uid: "");
      final result = await usecase(userDataWithoutUid);
      // assert
      expect(result, Success(userData));
      verify(() => mockAuthRepo.signup(userDataWithoutUid)).called(1);
      verifyNoMoreInteractions(mockAuthRepo);
    },
  );
}
