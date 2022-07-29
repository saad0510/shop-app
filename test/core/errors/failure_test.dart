import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/errors/failure.dart';

void main() {
  late AuthFailure authFailure;
  late AuthFailure authFailure2;
  late String expectedFailure;

  setUp(() {
    expectedFailure = "this is an exception";
    authFailure = AuthFailure("this is an exception");
    authFailure2 = AuthFailure("this is an exception");
  });

  test(
    'should return the expected message',
    () async {
      // assert
      expect(authFailure.message, expectedFailure);
    },
  );

  test(
    'should return true for equality of failures',
    () async {
      // act
      bool result = authFailure == authFailure2;
      // assert
      expect(result, true);
    },
  );
}
