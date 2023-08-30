import 'package:kisgeri24/services/authenticate.dart';
import 'package:test/test.dart';

void main() {
  group("Exception code resolution is not the expected!:", () {
    Map<String, String> inputs = {
      "invalid-email": "Email address is malformed.",
      "wrong-password": "Invalid email address or password.",
      "user-not-found": "Invalid email address or password.",
      "user-disabled": "This user has been disabled.",
      "too-many-requests": "Too many attempts to sign in as this user.",
      "something unmapped": "Unexpected firebase error, Please try again.",
    };
    inputs.forEach((input, expected) {
      test("Resolved message for $input is not the expected: $expected", () {
        expect(FireStoreUtils.resolveExceptionCode(input), expected);
      });
    });
  });
}
