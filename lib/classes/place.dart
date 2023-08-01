import 'package:flutter/foundation.dart';
import 'package:kisgeri24/classes/rockroute.dart';

class Place {
  String name;
  List<RockRoute> routeList;

  Place({
    required this.name,
    required this.routeList,
  });

  static Place fromSnapshot(String name, value) {
    //ToDo
    Map placeMap = value as Map<dynamic, dynamic>;
    String placeName = name;
    List<RockRoute> routeList = [];

    placeMap.forEach((key, value) { 
      final RockRoute route = RockRoute.fromSnapshot(value);
      routeList.add(route);
    });

    Place place = Place(name: placeName, routeList: routeList);
    return place;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.name == name &&
        listEquals(other.routeList, routeList);
  }

  @override
  int get hashCode => Object.hash(name, routeList);
}