import 'package:kisgeri24/services/validator.dart' as under_test;
import 'package:test/test.dart';

void main() {
  group("Testing phone number validation against invalid inputs.", () {
    Map<String?, String> inputs = {
      null: "Mobile phone number is required",
      "": "Mobile phone number is required",
      "abc1234567": "Mobile phone number must contain only digits",
      "123-45": "Mobile phone number must contain only digits",
      "+1 (123) 456-78901": "Mobile phone number must contain only digits",
      "12-34-567": "Mobile phone number must contain only digits",
      "+()1234567890": "Mobile phone number must contain only digits",
      "555.555.5555": "Mobile phone number must contain only digits",
      "+12 (3456) 7890": "Mobile phone number must contain only digits",
    };
    inputs.forEach((input, expected) {
      test(
          "Given response for the following phone number value [$input] is not the expected: $expected",
          () => {expect(under_test.validateMobile(input), expected)});
    });
  });

  group("Testing phone number validation against valid inputs.", () {
    Set<String> inputs = {
      "+36123456789",
      "+36(12)345-6789",
      "+36-12-345-6789",
      "+3612345678",
      "+36(1)234-5678",
      "+36-1-234-5678",
      "+361234567",
      "+36(12)345-678",
      "+36-12-345-678",
      "36123456789",
      "36(12)345-6789",
      "36-12-345-6789",
      "3612345678",
      "36(1)234-5678",
      "36-1-234-5678",
      "361234567",
      "36(12)345-678",
      "36-12-345-678",
      "06123456789",
      "06(12)345-6789",
      "06-12-345-6789",
      "0612345678",
      "06(1)234-5678",
      "06-1-234-5678",
      "061234567",
      "06(12)345-678",
      "06-12-345-678",
    };
    for (var input in inputs) {
      test(
          "The given input ($input) is not acceptable as a valid phone number!",
          () => {expect(under_test.validateMobile(input), null)});
    }
  });

  group("Testing password validation against invalid inputs.", () {
    Map<String?, String> inputs = {
      null: "Password must be more than 5 characters",
      "": "Password must be more than 5 characters",
      "1": "Password must be more than 5 characters",
      "12": "Password must be more than 5 characters",
      "123": "Password must be more than 5 characters",
      "1234": "Password must be more than 5 characters",
      "12345": "Password must be more than 5 characters"
    };
    inputs.forEach((input, expected) {
      test(
          "Given response for the following password [$input] is not the expected: $expected",
          () => {expect(under_test.validatePassword(input), expected)});
    });
  });

  test(
      "Test password length validation",
      () =>
          {expect(under_test.validatePassword("something_long_enough"), null)});
}
