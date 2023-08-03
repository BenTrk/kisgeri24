import 'package:flutter/foundation.dart';

class Results{
  num points;
  String start;
  ClimbedPlaces climberOneResults;
  ClimbedPlaces climberTwoResults;
  DidActivities climberOneActivities;
  DidActivities climberTwoActivities;
  TeamResults teamResults;
  PausedHandler pausedHandler;

  Results({
    required this.points,
    required this.start,
    ClimbedPlaces? climberOneResults,
    ClimbedPlaces? climberTwoResults,
    DidActivities? climberOneActivities,
    DidActivities? climberTwoActivities,
    TeamResults? teamResults,
    PausedHandler? pausedHandler, 
  }) : 
    climberOneResults = climberOneResults ?? ClimbedPlaces(climberName: ''),
    climberTwoResults = climberTwoResults ?? ClimbedPlaces(climberName: ''),
    climberOneActivities = climberOneActivities ?? DidActivities(climberName: ''),
    climberTwoActivities = climberTwoActivities ?? DidActivities(climberName: ''),
    teamResults = teamResults ?? TeamResults(),
    pausedHandler = pausedHandler ?? PausedHandler(isPaused: false, isPausedUsed: false);

    updatePointsAndStart(num points, String start){
      this.points = points;
      this.start = start;
    }

    getStart(){
      return start;
    }

    ClimbedPlaces getClimbedPlacesForAClimber(String climber){
      if (climber == climberOneResults.climberName){
        return climberOneResults;
      } else {
        return climberTwoResults;
      }
    }

    DidActivities getDidActivitiesForAClimber(String climber) {
      if (climber == climberOneActivities.climberName){
        return climberOneActivities;
      } else {
        return climberTwoActivities;
      }
    }
}

class PausedHandler {
  DateTime pauseOverTime;
  bool isPaused;
  bool isPausedUsed;

  PausedHandler({
    DateTime? pauseOverTime,
    required this.isPausedUsed,
    required this.isPaused,
  }) : pauseOverTime = pauseOverTime ?? DateTime(2023,07,02, 10, 10);

}

class DidActivities {
  String climberName;
  List<DidActivity> activitiesList;

  DidActivities({
    required this.climberName,
    List<DidActivity>? activitiesList,
  }) : activitiesList = activitiesList ?? [];

  bool getIsActivityThere(String activityName) {
    bool isThere = false;
    for (var element in activitiesList) {
      if (element.name == activityName){
        isThere = true;
      }
    }
    return isThere;
  }

  DidActivity getActivity(String activityName) {
    DidActivity didActivity = DidActivity();
    for (var element in activitiesList) {
      if (element.name == activityName){
        didActivity = element;
      }
    }
    return didActivity;
  } 

  static DidActivities fromSnapshot(value, name) {
    List<DidActivity> activityList = [];
    Map activityMap = value as Map<dynamic, dynamic>;

    activityMap.forEach((key, value) {
      String activityName = key as String;
      num points = 0;
      Map insideMap = value as Map<dynamic, dynamic>;
      insideMap.forEach((key, value) {
        points = value;
      });
       
      DidActivity activity = DidActivity(name: activityName, points: points);
      activityList.add(activity);
    });

    return DidActivities(climberName: name, activitiesList: activityList);
  }
}

class DidActivity {
  num points;
  String name;

  DidActivity({
    String? name,
    num? points,
  }) 
  : name = name ?? '',
    points = points ?? 0;
}

class TeamResults {
  /** TODO */
}

class ClimbedPlaces {
  String climberName;
  List<ClimbedPlace> climbedPlaceList;
  
  ClimbedPlaces({
    required this.climberName,
    List<ClimbedPlace>? climbedPlaceList,
  }) : climbedPlaceList = climbedPlaceList ?? [];
  
  bool getIsClimbThere(String routeName) {
    bool isThere = false;
    for (var element in climbedPlaceList) {
      for (var element in element.climbedRouteList) {
        if (element.name == routeName){
          isThere = true;
        }
      }
    }
    return isThere;
  }

  getRoute(String routeName){
    ClimbedRoute route = ClimbedRoute();
    for (var element in climbedPlaceList) {
      for (var element in element.climbedRouteList) {
        if (element.name == routeName){
          route = element;
        } 
      }
    }
    return route;
  }

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

  static ClimbedPlace fromSnapshot(value, placeName) {
    List<ClimbedRoute> climbedRouteList = [];

      Map routeMap = value as Map<dynamic, dynamic>;
      routeMap.forEach((key, value) {
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
    String? name,
    double? points,
    String? best,
  })
  : name = name ?? '',
    points = points ?? 0,
    best = best ?? '';

  
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

  getName(){
    return name;
  }
}