import "package:kisgeri24/data/converter/challenge_challenge_dto_converter.dart";
import "package:kisgeri24/data/dto/challenge_view.dart";
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

    ChallengeView result = underTest.convert(entity);

    expect(result.id, entity.id);
    expect(result.name, entity.name);
    expect(result.points, entity.points);
    expect(result.startTime, entity.startTime);
  });
}
