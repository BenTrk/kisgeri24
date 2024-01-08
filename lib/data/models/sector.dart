import 'package:flutter/foundation.dart';
import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/data/models/route.dart';

class Sector extends Entity {
  String name;
  List<Route> routes;

  Sector({
    required this.name,
    required this.routes,
  });

  static Sector fromSnapshot(String name, value) {
    Map placeMap = value as Map<dynamic, dynamic>;
    String placeName = name;
    List<Route> routeList = [];

    placeMap.forEach((key, value) {
      final Route route = Route.fromSnapshot(value);
      routeList.add(route);
    });

    Sector place = Sector(name: placeName, routes: routeList);
    return place;
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
    return 'Sector{name: $name, routes: ${routes.map((e) => e.name).toList().toString()}';
  }
}
