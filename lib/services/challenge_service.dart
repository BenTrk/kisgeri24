import "package:kisgeri24/data/converter/challenge_challenge_dto_converter.dart";
import "package:kisgeri24/data/converter/challenge_challenge_view_converter.dart";
import "package:kisgeri24/data/dto/challenge_dto.dart";
import "package:kisgeri24/data/dto/challenge_view.dart";
import "package:kisgeri24/data/models/challenge.dart";
import "package:kisgeri24/data/repositories/challenge_repository.dart";
import "package:kisgeri24/logging.dart";

class ChallengeService {
  final ChallengeRepository _repository;

  ChallengeService(this._repository);

  Future<List<ChallengeDto>> fetchAllByYear(String yearId) async {
    final List<ChallengeDto> challengeDtos = [];
    try {
      final List<Challenge> challenges = await _repository.fetchAllByYear(yearId);
      for (final Challenge challenge in challenges) {
        final ChallengeDto challengeDto =
            ChallengeToChallengeDtoConverter().convert(challenge);
        challengeDtos.add(challengeDto);
      }
    } catch (error) {
      logger.w("Error happened during Challenge fetch: $error");
    }

    return challengeDtos;
  }

  Future<List<ChallengeView>> getViewsByYear(String yearId) async {
    final List<ChallengeView> challengeViews = [];
    try {
      final List<Challenge> challenges = await _repository.fetchAllByYear(yearId);
      for (final Challenge challenge in challenges) {
        final ChallengeView challengeView =
            ChallengeToChallengeViewConverter().convert(challenge);
        challengeViews.add(challengeView);
      }
    } catch (error) {
      logger.w("Error happened during Challenge fetch: $error");
    }
    return challengeViews;
  }
}
