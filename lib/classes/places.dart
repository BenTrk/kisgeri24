import 'package:flutter/foundation.dart';
import 'package:kisgeri24/data/models/sector.dart';
import 'package:kisgeri24/data/models/route.dart';

@Deprecated('Places got replaced by Sectors')
class Places {
  List<Sector> placeList;

  Places({
    List<Sector>? placeList,
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
    Route route = Route();
    for (var element in placeList) {
      if (element.routes != null) {
        for (var element in element.routes!) {
          if (element.name == routeName) {
            route = element;
          }
        }
      }
    }
    return route;
  }

  String getPlaceWhereThisRoute(String routeName) {
    String placeName = '';
    for (var element in placeList) {
      String placeNameNow = element.name;
      if (element.routes != null) {
        for (var element in element.routes!) {
          if (element.name == routeName) {
            placeName = placeNameNow;
          }
        }
      }
    }
    return placeName;
  }
}
