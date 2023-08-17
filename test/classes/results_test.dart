import 'package:kisgeri24/classes/results.dart';
import 'package:test/test.dart';

void main() {
  test('Climber should not climbed there!', () {
    String firstClimberName = "A";
    String secondClimberName = "B";
    ClimbedPlaces firstClimber =
        createClimbedPlacesForClimber(firstClimberName);
    ClimbedPlaces secondClimber =
        createClimbedPlacesForClimber(secondClimberName);
    final counter = Results(
        points: 0,
        start: "someStart",
        climberOneResults: firstClimber,
        climberTwoResults: secondClimber);

    ClimbedPlaces didActivities =
        counter.getClimbedPlacesForAClimber(firstClimberName);

    expect(didActivities.getIsClimbThere("someNonExisting"), false);
  });
}

ClimbedPlaces createClimbedPlacesForClimber(String climberName,
    [List<ClimbedPlace>? places]) {
  return ClimbedPlaces(climberName: climberName, climbedPlaceList: places);
}
