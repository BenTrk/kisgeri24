import "package:flutter/foundation.dart";
import "package:kisgeri24/data/models/entity.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/wall.dart";

class Sector extends Entity {
  String name;
  int ordinal;
  List<Wall>? walls;
  List<Route>? routes;

  Sector(this.name, this.ordinal, this.walls, this.routes);

  static Sector fromSnapshot(String name, value) {
    final Map placeMap = value as Map<dynamic, dynamic>;
    final String placeName = name;
    final int ordinal =
        placeMap.containsKey("ordinal") ? placeMap["ordinal"] as int : 0;
    final List<Wall> wallList = [];
    final List<Route> routeList = [];

    if (_sectorHasSubWall(value)) {
      placeMap.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          final Wall wall = Wall.fromSnapshot(key, value);
          wallList.add(wall);
        }
      });
    } else {
      placeMap.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          final Route route = Route.fromSnapshot(value);
          routeList.add(route);
        }
      });
    }

    return Sector(placeName, ordinal, wallList, routeList);
  }

  static bool _sectorHasSubWall(dynamic value) {
    bool hasSubWall = true;
    value.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        final Map<String, dynamic> element = value;
        if (element.containsKey("points")) {
          hasSubWall = false;
          return;
        }
      }
    });
    return hasSubWall;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sector &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          ordinal == other.ordinal &&
          listEquals(walls, other.walls) &&
          listEquals(routes, other.routes);

  @override
  int get hashCode =>
      name.hashCode ^ ordinal.hashCode ^ walls.hashCode ^ routes.hashCode;

  @override
  String toString() {
    return "Sector{name: $name, ordinal: $ordinal, walls: $walls, routes: $routes}";
  }
}
