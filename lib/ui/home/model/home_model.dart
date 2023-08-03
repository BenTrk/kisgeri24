
import 'package:kisgeri24/misc/database_writes.dart';
import 'package:kisgeri24/publics.dart';

import '../../../classes/acivities.dart';
import '../../../classes/places.dart';
import 'package:kisgeri24/model/init.dart';

import '../../../model/user.dart';


class HomeModel{
  DatabaseWrites databaseWrites = DatabaseWrites();
  
  static Future<Places> getPlaces() async{
    places = await init.getPlacesWithRoutes();
    return places;
  }

  static Future<Activities> getActivities() async{
    activities = await init.getActivities();
    return activities;
  }

  static Future<Category> getOnlyClimbersCategory() async{
    climbersCategory = await init.getOnlyClimbersActivities();
    return climbersCategory;
  }

  void writePauseInformation(DateTime pauseTime, User user) {
    DateTime pauseOverTime = pauseTime.add(const Duration(hours: 1));
    databaseWrites.writePauseInformation(pauseOverTime, user);
  }

}