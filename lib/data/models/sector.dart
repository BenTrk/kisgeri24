import 'package:flutter/foundation.dart';
import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/data/models/route.dart';
import 'package:kisgeri24/data/models/wall.dart';

class Sector extends Entity {
  String name;
  List<Wall>? walls;
  List<Route>? routes;

  Sector(this.name, this.walls, this.routes);

  static Sector fromSnapshot(String name, value) {
    Map placeMap = value as Map<dynamic, dynamic>;
    String placeName = name;
    List<Wall> wallList = [];
    List<Route> routeList = [];

    if (_sectorHasSubWall(value)) {
      placeMap.forEach((key, value) {
        final Wall wall = Wall.fromSnapshot(key, value);
        wallList.add(wall);
      });
    } else {
      placeMap.forEach((key, value) {
        final Route route = Route.fromSnapshot(value);
        routeList.add(route);
      });
    }

    Sector place = Sector(placeName, wallList, routeList);
    return place;
  }

  static bool _sectorHasSubWall(dynamic value) {
    bool hasSubWall = true;
    value.forEach((key, value) {
      var element = value as Map<String, dynamic>;
      if (element.containsKey('points')) {
        hasSubWall = false;
        return;
      }
    });
    return hasSubWall;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sector &&
        other.name == name &&
        listEquals(other.routes, routes);
  }

  @override
  int get hashCode => Object.hash(name, routes);

  @override
  String toString() {
    return 'Sector{name: $name, walls: $walls, routes: $routes}';
  }
}
