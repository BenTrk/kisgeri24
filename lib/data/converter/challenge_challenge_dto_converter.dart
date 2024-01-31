import "dart:convert";

import "package:kisgeri24/data/dto/challenge_dto.dart";
import "package:kisgeri24/data/models/challenge.dart";
import "package:kisgeri24/logging.dart";

class ChallengeToChallengeDtoConverter
    extends Converter<Challenge, ChallengeDto> {
  @override
  ChallengeDto convert(Challenge input) {
    logger.d("Converting Challenge [$input] to its corresponding DTO");
    return ChallengeDto(
      input.id,
      input.name,
      input.points,
      input.yearId,
      input.startTime,
      input.endTime,
      input.details,
    );
  }
}
