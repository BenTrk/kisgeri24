import "package:kisgeri24/data/converter/user_user_dto_converter.dart";
import "package:kisgeri24/data/dto/user_dto.dart";
import "package:kisgeri24/data/models/user.dart";

import "../../test_utils/test_utils.dart";

import "package:test/test.dart";

late UserToUserDtoConverter underTest;

void main() {
  underTest = UserToUserDtoConverter();

  testConvert();
}

void testConvert() {
  test("Test convert from User to UserDto", () {
    User user = testUser;
    UserDto result = underTest.convert(user);

    expect(result != null, true);
    expect(result.email, user.email);
    expect(result.firstClimberName, user.firstClimberName);
    expect(result.secondClimberName, user.secondClimberName);
    expect(result.userID, user.userID);
    expect(result.teamName, user.teamName);
    expect(result.category, user.category);
    expect(result.startTime, user.startTime);
    expect(result.tenantId, user.tenantId);
    expect(result.yearId, user.yearId);
    expect(result.enabled, user.enabled);
  });
}
