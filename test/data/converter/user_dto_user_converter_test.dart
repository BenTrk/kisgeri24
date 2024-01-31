import "package:kisgeri24/data/converter/user_dto_user_converter.dart";
import "package:kisgeri24/data/dto/user_dto.dart";
import "package:kisgeri24/data/models/user.dart";

import "../../test_utils/test_utils.dart";

import "package:test/test.dart";

late UserDtoToUserConverter underTest;

void main() {
  underTest = UserDtoToUserConverter();

  testConvert();
}

void testConvert() {
  test("Test convert from UserDto to User", () {
    UserDto userDto = testUserAsDto;
    User result = underTest.convert(userDto);

    expect(result != null, true);
    expect(result.email, userDto.email);
    expect(result.firstClimberName, userDto.firstClimberName);
    expect(result.secondClimberName, userDto.secondClimberName);
    expect(result.userID, userDto.userID);
    expect(result.teamName, userDto.teamName);
    expect(result.category, userDto.category);
    expect(result.startTime, userDto.startTime);
    expect(result.tenantId, userDto.tenantId);
    expect(result.yearId, userDto.yearId);
    expect(result.enabled, userDto.enabled);
  });
}
