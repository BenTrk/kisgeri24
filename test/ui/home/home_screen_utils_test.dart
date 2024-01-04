import 'package:kisgeri24/ui/home/home_screen_utils.dart';
import "package:test/test.dart";

void main() {
  testGetEpochFromDateTime();
}

void testGetEpochFromDateTime() {
  test("Test getEpochFromDateTime against input", () {
    String exampleDateTime = '2023-08-09 - 19:00';
    int expected = 1691607600000;
    if (!new DateTime.timestamp().isUtc) {
      expected += 7200000;
    }

    expect(HomeScreenUtils.getEpochFromDateTime(exampleDateTime), expected);
  });
}
