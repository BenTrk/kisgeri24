import 'package:flutter/foundation.dart';
import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/data/models/route.dart';

class Wall extends Entity {
  String name;
  List<Route> routes;

  Wall({
    required this.name,
    required this.routes,
  });

  static Wall fromSnapshot(String name, value) {
    Map placeMap = value as Map<dynamic, dynamic>;
    String placeName = name;
    List<Route> routeList = [];

    placeMap.forEach((key, value) {
      final Route route = Route.fromSnapshot(value);
      routeList.add(route);
    });

    Wall place = Wall(name: placeName, routes: routeList);
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
