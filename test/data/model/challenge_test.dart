import 'package:kisgeri24/data/models/challenge.dart';
import "package:test/test.dart";

final Map<String, double> testPoints = {'key': 123};

void main() {
  testChallengeEquality();
  testChallengeInequality();
  testChallengeInequalityWithNull();
  testChallengeInequalityWithDifferentType();
  testChallengeWhenHasPoints();
  testChallengeWhenHasNoPoints();
}

void testChallengeEquality() {
  test('Challenge equality', () {
    Challenge challenge1 = new Challenge('testId', 'testYearId', 'testName',
        123, 456, 'testDetails', testPoints);
    Challenge challenge2 = new Challenge('testId', 'testYearId', 'testName',
        123, 456, 'testDetails', testPoints);

    expect(challenge1 == challenge2, true);
  });
}

void testChallengeInequality() {
  test('Challenge inequality', () {
    Challenge challenge1 = new Challenge('testId', 'testYearId', 'testName',
        123, 456, 'testDetails', testPoints);
    Challenge challenge2 = new Challenge('testId2', 'testYearId2', 'testName2',
        1234, 4567, 'testDetails2', testPoints);

    expect(challenge1 == challenge2, false);
  });
}

void testChallengeInequalityWithNull() {
  test('Challenge inequality with null', () {
    Challenge challenge1 = new Challenge('testId', 'testYearId', 'testName',
        123, 456, 'testDetails', testPoints);
    Challenge? challenge2 = null;

    expect(challenge1 == challenge2, false);
  });
}

void testChallengeInequalityWithDifferentType() {
  test('Challenge inequality with different type', () {
    Challenge challenge1 = new Challenge('testId', 'testYearId', 'testName',
        123, 456, 'testDetails', testPoints);
    String challenge2 = 'testName';

    expect(challenge1 == challenge2, false);
  });
}

void testChallengeWhenHasPoints() {
  test('Challenge when has points', () {
    Map<String, dynamic> parsedJson = {
      'id': 'testId',
      'yearId': 'testYearId',
      'name': 'testName',
      'startTime': 123,
      'endTime': 456,
      'details': 'testDetails',
      'points': {'testKey': 123}
    };

    Challenge challenge = Challenge.fromJson(parsedJson);

    expect(challenge.points, {'testKey': 123});
  });
}

void testChallengeWhenHasNoPoints() {
  test('Challenge when has no points', () {
    Map<String, dynamic> parsedJson = {
      'id': 'testId',
      'yearId': 'testYearId',
      'name': 'testName',
      'startTime': 123,
      'endTime': 456,
      'details': 'testDetails',
    };

    bool errorCaught = false;
    try {
      Challenge challenge = Challenge.fromJson(parsedJson);
    } on TypeError catch (error) {
      errorCaught = true;
    } catch (error) {
      fail('Unexpected error happened: $error');
    } finally {
      if (!errorCaught) {
        fail('No error happened when expected.');
      }
    }
  });
}
