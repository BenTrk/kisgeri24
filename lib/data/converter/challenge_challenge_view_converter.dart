import "dart:convert";

import "package:kisgeri24/data/dto/challenge_view.dart";
import "package:kisgeri24/data/models/challenge.dart";
import "package:kisgeri24/logging.dart";

class ChallengeToChallengeViewConverter
    extends Converter<Challenge, ChallengeView> {
  @override
  ChallengeView convert(Challenge input) {
    logger.d("Converting Challenge [$input] to its corresponding View");
    return ChallengeView(input.id, input.name, input.startTime, input.points);
  }
}
