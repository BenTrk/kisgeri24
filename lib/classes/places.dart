import 'package:flutter/foundation.dart';
import 'package:kisgeri24/classes/place.dart';
import 'package:kisgeri24/classes/rockroute.dart';

class Places {
  List<Place> placeList;

  Places({
    List<Place>? placeList,
  }) : placeList = placeList ?? [];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Places && listEquals(other.placeList, placeList);
  }

  @override
  int get hashCode => placeList.hashCode;

  getPlaceName(int position) {
    return placeList[position].name;
  }

  getRoute(String routeName) {
    RockRoute route = RockRoute();
    for (var element in placeList) {
      for (var element in element.routeList) {
        if (element.name == routeName) {
          route = element;
        }
      }
    }
    return route;
  }

  String getPlaceWhereThisRoute(String routeName) {
    String placeName = '';
    for (var element in placeList) {
      String placeNameNow = element.name;
      for (var element in element.routeList) {
        if (element.name == routeName) {
          placeName = placeNameNow;
        }
      }
    }
    return placeName;
  }
}
