
import 'package:kisgeri24/publics.dart';

import '../../../classes/acivities.dart';
import '../../../classes/places.dart';
import 'package:kisgeri24/model/init.dart';


class HomeModel{
  
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

}