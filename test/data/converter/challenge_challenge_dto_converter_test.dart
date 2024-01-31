import "package:kisgeri24/data/converter/challenge_challenge_dto_converter.dart";
import "package:kisgeri24/data/dto/challenge_dto.dart";
import "package:kisgeri24/data/models/challenge.dart";
import "package:test/test.dart";

late ChallengeToChallengeDtoConverter underTest;

void main() {
  testConvert();
}

void testConvert() {
  test('Convert', () {
    underTest = ChallengeToChallengeDtoConverter();
    Challenge entity = new Challenge(
      'testId',
      'testYearId',
      'testName',
      123,
      456,
      'testDetails',
      {'category': 123},
    );
    ChallengeDto expected = new ChallengeDto(
      entity.id,
      entity.name,
      entity.points,
      entity.yearId,
      entity.startTime,
      entity.endTime,
      entity.details,
    );

    expect(underTest.convert(entity) == expected, true);
  });
}
