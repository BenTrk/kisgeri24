import 'package:flutter/foundation.dart';

class Results{
  num points;
  String start;
  ClimbedPlaces climberOneResults;
  ClimbedPlaces climberTwoResults;
  TeamResults teamResults;

  Results({
    required this.points,
    required this.start,
    ClimbedPlaces? climberOneResults,
    ClimbedPlaces? climberTwoResults,
    TeamResults? teamResults, 
  }) : 
    climberOneResults = climberOneResults ?? ClimbedPlaces(),
    climberTwoResults = climberTwoResults ?? ClimbedPlaces(),
    teamResults = teamResults ?? TeamResults();

    updatePointsAndStart(num points, String start){
      this.points = points;
      this.start = start;
    }

    getStart(){
      return this.start;
    }
}

class TeamResults {

}

class ClimbedPlaces {
  List<ClimbedPlace> climbedPlaceList;
  
  ClimbedPlaces({
    List<ClimbedPlace>? climbedPlaceList,
  }) : climbedPlaceList = climbedPlaceList ?? [];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClimbedPlaces && listEquals(other.climbedPlaceList, climbedPlaceList);
  }

  @override
  int get hashCode => climbedPlaceList.hashCode;

}

class ClimbedPlace {
  String name;
  List<ClimbedRoute> climbedRouteList;

  ClimbedPlace({
    required this.name,
    required this.climbedRouteList,
  });

  static ClimbedPlace fromSnapshot(String name, value) {
    //ToDo
    Map placeMap = value as Map<dynamic, dynamic>;
    String placeName = name;
    List<ClimbedRoute> climbedRouteList = [];

    placeMap.forEach((key, value) { 
      final ClimbedRoute climbedRoute = ClimbedRoute.fromSnapshot(value);
      climbedRouteList.add(climbedRoute);
    });

    ClimbedPlace place = ClimbedPlace(name: placeName, climbedRouteList: climbedRouteList);
    return place;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClimbedPlace &&
        other.name == name &&
        listEquals(other.climbedRouteList, climbedRouteList);
  }

  @override
  int get hashCode => Object.hash(name, climbedRouteList);
}

class ClimbedRoute {
  String best;
  String name;
  double points;

  ClimbedRoute({
    required this.name,
    required this.points,
    required this.best,
  });
  
  static ClimbedRoute fromSnapshot(value) {
    Map routeMap = value as Map<dynamic, dynamic>;
    String name = '';
    double points = 0;
    String best = '';

    routeMap.forEach((key, value) {
      if (key == 'name'){
        name = value;
      } else if (key == 'points'){
        points = double.parse(value.toString());
      } else if (key == 'best'){
        best = value;
      }
    });

    ClimbedRoute route = ClimbedRoute(name: name, points: points, best: best);
    return route;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClimbedRoute &&
        other.name == name &&
        other.points == points &&
        other.best == best;
  }

  @override
  int get hashCode =>
      Object.hash(name, points, best);
}