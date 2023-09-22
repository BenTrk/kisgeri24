import 'package:kisgeri24/services/utils.dart';
import 'package:test/test.dart';

void main() {
  group("isNullOrEmpty did not get resolved properly", () {
    List<String?> inputsForTrue = ["", null];
    for (var input in inputsForTrue) {
      test(
          "Checking if isNullOrEmpty resolves the input [$input] correctly as true.",
          () {
        expect(isNullOrEmpty(input), true);
      });
    }

    test("Checking if isNullOrEmpty resolves the input correctly as false.",
        () {
      expect(isNullOrEmpty("something"), false);
    });
  });
}
