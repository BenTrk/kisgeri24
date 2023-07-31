import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../classes/places.dart';
import 'package:kisgeri24/model/init.dart';


class HomeModel{
  
  static Future<Places> getPlaces() async{
    Places places;
    return places = await init.getPlacesWithRoutes();
  }

}