
import '../../../classes/acivities.dart';
import '../../../classes/places.dart';
import 'package:kisgeri24/model/init.dart';


class HomeModel{
  
  static Future<Places> getPlaces() async{
    return await init.getPlacesWithRoutes();
  }

  static Future<Activities> getActivities() async{
    return await init.getActivities();
  }

}