import "dart:convert";

import "package:kisgeri24/data/dto/user_dto.dart";
import "package:kisgeri24/data/models/user.dart";
import "package:kisgeri24/logging.dart";

class UserToUserDtoConverter extends Converter<User, UserDto> {
  @override
  UserDto convert(User input) {
    logger.d("Converting User [$input] to its corresponding DTO");
    return UserDto(
      input.email,
      input.firstClimberName,
      input.secondClimberName,
      input.userID,
      input.teamName,
      input.category,
      input.appIdentifier,
      input.startTime,
      input.tenantId,
      input.yearId,
      input.enabled,
    );
  }
}
