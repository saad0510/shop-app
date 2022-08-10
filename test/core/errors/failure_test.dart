import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/errors/failure.dart';

void main() {
  const String errorMsg = "this is an exception";

  test(
    'should return the expected message',
    () async {
      const authFailure = AuthFailure(errorMsg);
      expect(authFailure.message, errorMsg);
    },
  );

  test(
    'should return true for equality of failures',
    () async {
      const authFailure = AuthFailure(errorMsg);
      const authFailure2 = AuthFailure(errorMsg);
      bool result = authFailure == authFailure2;
      expect(result, true);
    },
  );
}
