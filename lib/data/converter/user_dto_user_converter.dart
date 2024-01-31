import "dart:convert";

import "package:kisgeri24/data/dto/user_dto.dart";
import "package:kisgeri24/data/models/user.dart";
import "package:kisgeri24/logging.dart";

class UserDtoToUserConverter extends Converter<UserDto, User> {
  @override
  User convert(UserDto input) {
    logger.d("Converting UserDto [$input] to its corresponding User entity");
    return User(
      email: input.email,
      firstClimberName: input.firstClimberName,
      secondClimberName: input.secondClimberName,
      userID: input.userID,
      teamName: input.teamName,
      category: input.category,
      startTime: input.startTime,
      tenantId: input.tenantId,
      yearId: input.yearId,
      enabled: input.enabled,
    );
  }
}
