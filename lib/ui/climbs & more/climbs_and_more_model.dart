
import 'package:kisgeri24/misc/database_writes.dart';

import '../../classes/results.dart';
import '../../publics.dart';

class ClimbsAndMoreModel{
  DatabaseWrites databaseWrites = DatabaseWrites();

  static DidActivities getDidActivities(String climberName) {
    if (results.climberOneActivities.climberName == climberName){
      return results.climberOneActivities;
    } else {
      return results.climberTwoActivities;
    }
  }

  static ClimbedPlaces getClimbedClimbs(String climberName) {
    if (results.climberOneResults.climberName == climberName){
      return results.climberOneResults;
    } else {
      return results.climberTwoResults;
    }
  }
  
}