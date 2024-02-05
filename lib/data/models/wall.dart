import 'package:flutter/foundation.dart';
import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/data/models/route.dart';

class Wall extends Entity {
  String name;
  int ordinal;
  List<Route> routes;

  Wall({
    required this.name,
    required this.ordinal,
    required this.routes,
  });

  static Wall fromSnapshot(String name, value) {
    final Map placeMap = value as Map<dynamic, dynamic>;
    final String placeName = name;
    final int ordinal =
        placeMap.containsKey("ordinal") ? placeMap["ordinal"] as int : 0;
    final List<Route> routeList = [];

    placeMap.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        routeList.add(Route.fromSnapshot(value));
      }
    });

    Wall place = Wall(name: placeName, ordinal: ordinal, routes: routeList);
    return place;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Wall &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          listEquals(routes, other.routes);

  @override
  int get hashCode => name.hashCode ^ routes.hashCode;

  @override
  String toString() {
    return 'Wall{name: $name, routes: $routes}';
  }
}
