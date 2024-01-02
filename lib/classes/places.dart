import "package:flutter/foundation.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/sector.dart";

@Deprecated("Places got replaced by Sectors")
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

  String getPlaceName(int position) {
    return placeList[position].name;
  }

  Route getRoute(String routeName) {
    Route route = Route();
    for (final element in placeList) {
      if (element.routes != null) {
        for (final element in element.routes!) {
          if (element.name == routeName) {
            route = element;
          }
        }
      }
    }
    return route;
  }

  String getPlaceWhereThisRoute(String routeName) {
    String placeName = "";
    for (final element in placeList) {
      final String placeNameNow = element.name;
      if (element.routes != null) {
        for (final element in element.routes!) {
          if (element.name == routeName) {
            placeName = placeNameNow;
          }
        }
      }
    }
    return placeName;
  }
}
