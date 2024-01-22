import 'dart:convert';

import 'package:kisgeri24/data/dto/challenge_dto.dart';
import 'package:kisgeri24/data/models/challenge.dart';

class ChallengeToChallengeDtoConverter
    extends Converter<Challenge, ChallengeDto> {
  @override
  ChallengeDto convert(Challenge input) {
    return ChallengeDto(input.id, input.name, input.points, input.yearId,
        input.startTime, input.endTime, input.details);
  }
}
