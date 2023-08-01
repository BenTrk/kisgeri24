import 'package:flutter/foundation.dart';

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

  getPlaceName(int position){
    return placeList[position].name;
  }
}

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

class RockRoute {
  String name;
  double points;
  int length;
  int key;
  int difficulty;
  String diffchanger;

  RockRoute({
    required this.name,
    required this.points,
    required this.length,
    required this.key,
    required this.difficulty,
    required this.diffchanger,
  });
  
  static RockRoute fromSnapshot(value) {
    Map routeMap = value as Map<dynamic, dynamic>;
    String name = '';
    double points = 0;
    int length = 0; 
    int keyHere = 0;
    int difficulty = 0;
    String diffchanger = '';

    routeMap.forEach((key, value) {
      if (key == 'name'){
        name = value;
      } else if (key == 'points'){
        points = double.parse(value.toString());
      } else if (key == 'length'){
        length = value;
      } else if (key == 'key'){
        keyHere = value;
      } else if (key == 'difficulty'){
        difficulty = value;
      } else if (key == 'diffchanger'){
        diffchanger = value;
      }
    });

    RockRoute route = RockRoute(name: name, points: points, length: length, key: keyHere, difficulty: difficulty, diffchanger: diffchanger);
    return route;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RockRoute &&
        other.name == name &&
        other.points == points &&
        other.length == length &&
        other.key == key &&
        other.difficulty == difficulty &&
        other.diffchanger == diffchanger;
  }

  @override
  int get hashCode =>
      Object.hash(name, points, length, key, difficulty, diffchanger);

}