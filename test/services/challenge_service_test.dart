import 'package:kisgeri24/data/dto/challenge_dto.dart';
import 'package:kisgeri24/data/dto/challenge_view.dart';
import 'package:kisgeri24/data/models/challenge.dart';
@GenerateNiceMocks([MockSpec<ChallengeRepository>()])
import 'package:kisgeri24/data/repositories/challenge_repository.dart';
import 'package:kisgeri24/services/challenge_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'challenge_service_test.mocks.dart';

final Map<String, double> testPoints = {'key': 123};

late ChallengeService underTest;
late MockChallengeRepository mockChallengeRepository;

void main() {
  testGetAllByYearWhenNoChallengeComingBackFromDatabase();
  testGetAllByYearWhenSingleChallengeComingBackFromDatabase();
  testGetAllByYearWhenMultipleChallengeComingBackFromDatabase();

  testGetViewsByYearWhenNoChallengeComingBackFromDatabase();
  testGetViewsByYearWhenSingleChallengeComingBackFromDatabase();
  testGetViewsByYearWhenMultipleChallengeComingBackFromDatabase();
}

void configure() {
  mockChallengeRepository = MockChallengeRepository();
  underTest = ChallengeService(mockChallengeRepository);
}

void testGetAllByYearWhenNoChallengeComingBackFromDatabase() {
  configure();
  test('Test challenge fetch when no challenge can be fetched from DB',
      () async {
    when(mockChallengeRepository.fetchAllByYear(any))
        .thenAnswer((_) async => Future.value(List.empty()));

    List<ChallengeDto> result = await underTest.fetchAllByYear('testYearId');

    expect(result != null, true);
    expect(result.length, 0);
  });
}

void testGetAllByYearWhenSingleChallengeComingBackFromDatabase() {
  configure();
  test('Test challenge fetch when a single challenge can be fetched from DB',
      () async {
    List<Challenge> challengesFromDb = [createTestChallenge()];
    when(mockChallengeRepository.fetchAllByYear(any))
        .thenAnswer((_) async => Future.value(challengesFromDb));

    List<ChallengeDto> result = await underTest.fetchAllByYear('testYearId');

    expect(result != null, true);
    expect(result.length, challengesFromDb.length);
    expect(result[0].name, challengesFromDb[0].name);
  });
}

void testGetAllByYearWhenMultipleChallengeComingBackFromDatabase() {
  configure();
  test('Test challenge fetch when a single challenge can be fetched from DB',
      () async {
    List<Challenge> challengesFromDb = createTestChallenges(3);
    when(mockChallengeRepository.fetchAllByYear(any))
        .thenAnswer((_) async => Future.value(challengesFromDb));

    List<ChallengeDto> result = await underTest.fetchAllByYear('testYearId');

    expect(result != null, true);
    expect(result.length, challengesFromDb.length);
    expect(result[0].name, challengesFromDb[0].name);
    expect(result[1].name, challengesFromDb[1].name);
    expect(result[2].name, challengesFromDb[2].name);
  });
}

void testGetViewsByYearWhenNoChallengeComingBackFromDatabase() {
  configure();
  test('Test challenge fetch when no challenge can be fetched from DB',
      () async {
    when(mockChallengeRepository.fetchAllByYear(any))
        .thenAnswer((_) async => Future.value(List.empty()));

    List<ChallengeView> result = await underTest.getViewsByYear('testYearId');

    expect(result != null, true);
    expect(result.length, 0);
  });
}

void testGetViewsByYearWhenSingleChallengeComingBackFromDatabase() {
  configure();
  test('Test challenge fetch when a single challenge can be fetched from DB',
      () async {
    List<Challenge> challengesFromDb = [createTestChallenge()];
    when(mockChallengeRepository.fetchAllByYear(any))
        .thenAnswer((_) async => Future.value(challengesFromDb));

    List<ChallengeView> result = await underTest.getViewsByYear('testYearId');

    expect(result != null, true);
    expect(result.length, challengesFromDb.length);
    expect(result[0].name, challengesFromDb[0].name);
  });
}

void testGetViewsByYearWhenMultipleChallengeComingBackFromDatabase() {
  configure();
  test('Test challenge fetch when a single challenge can be fetched from DB',
      () async {
    List<Challenge> challengesFromDb = createTestChallenges(3);
    when(mockChallengeRepository.fetchAllByYear(any))
        .thenAnswer((_) async => Future.value(challengesFromDb));

    List<ChallengeView> result = await underTest.getViewsByYear('testYearId');

    expect(result != null, true);
    expect(result.length, challengesFromDb.length);
    expect(result[0].name, challengesFromDb[0].name);
    expect(result[1].name, challengesFromDb[1].name);
    expect(result[2].name, challengesFromDb[2].name);
  });
}

List<Challenge> createTestChallenges(int count) {
  List<Challenge> challenges = [];
  for (int i = 0; i < count; i++) {
    challenges.add(createTestChallenge(postfix: i.toString()));
  }
  return challenges;
}

Challenge createTestChallenge({String? postfix}) {
  String preparedPostfix = postfix == null ? '' : '-$postfix';
  return Challenge(
      'testChallengeId$preparedPostfix',
      'testYearId',
      'testChallengeName$preparedPostfix',
      DateTime.now().millisecondsSinceEpoch,
      DateTime.now().millisecondsSinceEpoch,
      null,
      testPoints);
}
