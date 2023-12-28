import 'package:kisgeri24/misc/database_writes.dart';

import '../../classes/results.dart';
import '../../data/models/user.dart';
import '../../publics.dart';

class ClimbsAndMoreModel {
  DatabaseWrites databaseWrites = DatabaseWrites();

  static TeamResults getTeamResults() {
    return results.teamResults;
  }

  static DidActivities getDidActivities(String climberName) {
    if (results.climberOneActivities.climberName == climberName) {
      return results.climberOneActivities;
    } else {
      return results.climberTwoActivities;
    }
  }

  static ClimbedPlaces getClimbedClimbs(String climberName) {
    if (results.climberOneResults.climberName == climberName) {
      return results.climberOneResults;
    } else {
      return results.climberTwoResults;
    }
  }

  void removeClimbOrActivity(
      climbOrActivity, User user, String climberName, String placeName) {
    switch (climbOrActivity.runtimeType) {
      case (ClimbedRoute):
        {
          databaseWrites.removeClimbedRoute(
              climbOrActivity as ClimbedRoute, climberName, user, placeName);
          break;
        }
      case (DidActivity):
        {
          databaseWrites.removeDidActivity(
              climbOrActivity as DidActivity, climberName, user);
          break;
        }
    }
  }
}
