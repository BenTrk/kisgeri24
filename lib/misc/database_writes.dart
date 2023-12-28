import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kisgeri24/classes/results.dart';
import 'package:kisgeri24/classes/rockroute.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../data/models/user.dart';
import '../publics.dart';

class DatabaseWrites {
  DatabaseReference ref = FirebaseDatabase.instance.ref('Results');

  void writePauseInformation(DateTime pauseOverTime, User user) async {
    DatabaseReference resultsRef =
        FirebaseDatabase.instance.ref('Results').child(user.userID);
    final snapshotResult = await resultsRef.get();
    String userStartTime = snapshotResult.child('start').value.toString();
    userStartTime = userStartTime.replaceFirst(RegExp(' - '), 'T');
    DateTime userStartDateTime = DateTime.parse(userStartTime);
    userStartDateTime = userStartDateTime.add(const Duration(hours: 1));

    String formattedStartTime =
        DateFormat('yyyy-MM-dd - HH:mm').format(userStartDateTime);
    String formattedDateTime =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(pauseOverTime);

    await ref.child(user.userID).update({
      "pauseHandler/pauseOverTime": formattedDateTime,
      "pauseHandler/isPausedUsed": true,
      "start": formattedStartTime,
    });
  }

  writeClimbToDatabase(BuildContext context, User user, String climber,
      String route, String style) async {
    //if -1, then something went wrong!
    num points = calculateRoutePoints(route, style);
    String place = places.getPlaceWhereThisRoute(route);

    String bestStyle = getBest(style, climber, route);
    if (compareStyles(style, bestStyle) >= 0) {
      await ref.child(user.userID).update({
        "Climbs/$climber/$place/$route/best": style,
        "Climbs/$climber/$place/$route/points": points,
        "Climbs/$climber/$place/$route/name": route,
        "points": calculatePoints(
            points, getIsClimbThere(route, climber), climber, route),
      }).then(
          (document) => showSnackBar(context, 'Climb added to the database!'));
    }
  }

  writeActivityToDatabase(BuildContext context, User user, String climber,
      String activity, num points) async {
    //if -1, then something went wrong!
    bool isBestActivity = getBestActivity(climber, activity, points);

    if (isBestActivity) {
      await ref.child(user.userID).update({
        "Activities/$climber/$activity/points": points,
        "points": calculateActivityPoints(
            points, getIsActivityThere(activity, climber), climber, activity),
      }).then((document) =>
          showSnackBar(context, 'Activity added to the database!'));
    }
  }

  void removeClimbedRoute(ClimbedRoute climb, String climberName, User user,
      String placeName) async {
    await ref
        .child(user.userID)
        .child('Climbs')
        .child(climberName)
        .child(placeName)
        .child(climb.name)
        .remove();
    //Points, you jackass :)
    num newPoints = results.points - climb.points;
    await ref.child(user.userID).update({"points": newPoints});
  }

  void removeDidActivity(
      DidActivity activity, String climberName, User user) async {
    await ref
        .child(user.userID)
        .child('Activities')
        .child(climberName)
        .child(activity.name)
        .remove();
    //Points, you jackass :)
    num newPoints = results.points - activity.points;
    await ref.child(user.userID).update({"points": newPoints});
  }
}

getIsActivityThere(String activityName, String climberName) {
  if (climberName == results.climberOneActivities.climberName) {
    return results.climberOneActivities.getIsActivityThere(activityName);
  } else {
    return results.climberTwoActivities.getIsActivityThere(activityName);
  }
}

calculateActivityPoints(
    num points, isActivityThere, String climber, String activityName) {
  DidActivities didActivities = results.getDidActivitiesForAClimber(climber);
  if (isActivityThere) {
    num activityPointsBefore = didActivities.getActivity(activityName).points;
    num teamPoints = results.points;
    return (teamPoints - activityPointsBefore) + points;
  } else {
    return results.points + points;
  }
}

bool getBestActivity(String climberName, String activityName, num points) {
  if (climberName == results.climberOneActivities.climberName) {
    num activityPointsBefore =
        results.climberOneActivities.getActivity(activityName).points;
    if (points > activityPointsBefore) {
      return true;
    } else {
      return false;
    }
  } else {
    num activityPointsBefore =
        results.climberTwoActivities.getActivity(activityName).points;
    if (points > activityPointsBefore) {
      return true;
    } else {
      return false;
    }
  }
}

bool getIsClimbThere(String routeName, String climberName) {
  if (climberName == results.climberOneResults.climberName) {
    return results.climberOneResults.getIsClimbThere(routeName);
  } else {
    return results.climberTwoResults.getIsClimbThere(routeName);
  }
}

String getBest(String style, String climber, String route) {
  String bestStyle = style;
  ClimbedPlaces climbedPlaces = results.getClimbedPlacesForAClimber(climber);
  for (var element in climbedPlaces.climbedPlaceList) {
    for (var element in element.climbedRouteList) {
      if (element.name == route) {
        String styleInDB = element.best;
        int comparison = compareStyles(style, styleInDB);
        switch (comparison) {
          case (-1):
            {
              bestStyle = styleInDB;
              //return already have better
              break;
            }
          case (0):
            {
              //return nice, but same points
              break;
            }
          case (1):
            {
              //return well done, saved points
            }
        }
      }
    }
  }
  return bestStyle;
}

// Define a custom comparator function for the styles
int compareStyles(String style1, String style2) {
  final index1 = styles.indexOf(style1);
  final index2 = styles.indexOf(style2);

  if (index1 < index2) {
    return -1;
  } else if (index1 > index2) {
    return 1;
  } else {
    return 0;
  }
}

num calculateRoutePoints(String route, String style) {
  RockRoute routeHere = places.getRoute(route);
  num pointsHere = routeHere.points;

  switch (style) {
    case ('Top-Rope'):
      {
        return pointsHere * 0.5;
      }
    case ('Lead'):
      {
        return pointsHere;
      }
    case ('Clean'):
      {
        return pointsHere * 2;
      }
  }

  return -1;
}

num calculatePoints(
    num points, bool isClimbThere, String climber, String routeName) {
  ClimbedPlaces climbedPlaces = results.getClimbedPlacesForAClimber(climber);
  if (isClimbThere) {
    num routePointsBefore = climbedPlaces.getRoute(routeName).points;
    num teamPoints = results.points;
    return (teamPoints - routePointsBefore) + points;
  } else {
    return results.points + points;
  }
}
