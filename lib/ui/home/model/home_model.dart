
import '../../../classes/acivities.dart';
import '../../../classes/places.dart';
import 'package:kisgeri24/model/init.dart';


class HomeModel{
  
  static Future<Places> getPlaces() async{
    Places places;
    return places = await init.getPlacesWithRoutes();
  }

  static Future<Activities> getActivities() async{
    Activities activities;
    return activities = await init.getActivities();
  }

}