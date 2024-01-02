import "dart:async";

import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:kisgeri24/classes/acivities.dart";
import "package:kisgeri24/classes/places.dart";
import "package:kisgeri24/classes/results.dart";
import "package:kisgeri24/data/models/sector.dart";
import "package:kisgeri24/data/models/user.dart";
import "package:kisgeri24/logging.dart" as log;
import "package:kisgeri24/publics.dart";

class Init {
  //Compare starttime and starttime + category to start and end times
  //return true if in range, false, if out of range
  //Take extra care when adding dates for testing manually - the format is important
  static Duration getTimeUntilStartTime(String startTime) {
    Duration duration = Duration.zero;
    DateTime userStartDateTime;

    final String userStartTime = startTime.replaceFirst(RegExp(" - "), "T");
    if (userStartTime == "") {
      //?
      userStartDateTime = DateTime(2017, 9, 7, 17, 30);
    } else {
      userStartDateTime = DateTime.parse(userStartTime);
    }

    duration = DateTime.now().difference(userStartDateTime);

    return duration;
  }

  static int getTenMinutesLeftDurationInMinutes(int category) {
    category = category * 60; //so it is in minutes
    category = category - 10; //so it is 10 minutes before the end
    return category;
  }

  static int getOneHourLeftDurationInHours(int category) {
    category = category - 1;
    return category;
  }

  static int getCategoryTime(User user) {
    String category = user.category;
    int categoryTime = 0;

    category = category.replaceAll("H", "");
    categoryTime = int.parse(category);

    return categoryTime;
  }

  static String getEndDate(User user, String startTime) {
    final String userCategory = user.category;
    Duration duration = Duration.zero;
    DateTime userStartDateTime;

    final String userStartTime = startTime.replaceFirst(RegExp(" - "), "T");
    if (userStartTime == "") {
      userStartDateTime = DateTime.now();
    } else {
      userStartDateTime = DateTime.parse(userStartTime);
    }

    switch (userCategory) {
      case ("6H"):
        {
          duration = const Duration(hours: 6);
          break;
        }
      case ("12H"):
        {
          duration = const Duration(hours: 12);
          break;
        }
      case ("24H"):
        {
          duration = const Duration(hours: 24);
          break;
        }
    }

    final DateTime userEndDateTime = userStartDateTime.add(duration);

    return DateFormat("hh:mm - dd-MM").format(userEndDateTime);
  }

  //ToDo: Use try catch for dates, do not initialize on start for stupid values!
  static Future<bool> checkDateTime(User user) async {
    log.logger.d("Check date is requested for user: $user");
    final DatabaseReference basicRef = FirebaseDatabase.instance.ref("BasicData");
    final DatabaseReference resultsRef =
        FirebaseDatabase.instance.ref("Results").child(user.userID);
    DateTime compStartDateTime = DateTime(1969, 07, 20, 20, 17);
    DateTime userStartDateTime = DateTime(1969, 07, 20, 20, 17);
    final String userCategory = user.category;
    Duration duration = const Duration();
    bool isInRange = false;

    final snapshot = await basicRef.get();
    if (snapshot.exists) {
      String compStartTime = snapshot.child("compStartTime").value.toString();

      compStartTime = compStartTime.replaceFirst(RegExp(" - "), "T");
      compStartDateTime = DateTime.parse(compStartTime);
    } else {
      return isInRange;
    }

    final snapshotResult = await resultsRef.get();

    if (snapshotResult.exists) {
      String userStartTime = snapshotResult.child("start").value.toString();
      userStartTime = userStartTime.replaceFirst(RegExp(" - "), "T");
      userStartDateTime = DateTime.parse(userStartTime);
    } else {
      return isInRange;
    }

    switch (userCategory) {
      case ("6H"):
        {
          duration = const Duration(hours: 6);
          break;
        }
      case ("12H"):
        {
          duration = const Duration(hours: 12);
          break;
        }
      case ("24H"):
        {
          duration = const Duration(hours: 24);
          break;
        }
    }

    final DateTime userEndDateTime = userStartDateTime.add(duration);

    if (DateTime.now().isBefore(compStartDateTime) ||
        DateTime.now().isAfter(userEndDateTime)) {
      isInRange = false;
    } else {
      isInRange = true;
    }

    return isInRange;
  }

  static getPauseOver(User user, BuildContext context) async {
    final DatabaseReference resultsRef =
        FirebaseDatabase.instance.ref("Results").child(user.userID);
    final String formattedDateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now());

    await resultsRef.update({"pauseHandler/pauseOverTime": formattedDateTime});

    final DataSnapshot dataSnapshot = await resultsRef.get();
    Init.getResults(user, dataSnapshot);
  }

  //maybe Future<Results>?
  static getResults(User user, DataSnapshot dataSnapshot) async {
    num points = 0.0;
    String start = "";

    final List<ClimbedPlace> firstClimberList = [];
    final List<ClimbedPlace> secondClimberList = [];
    ClimbedPlaces climbedPlacesClimberOne =
        ClimbedPlaces(climberName: user.firstClimberName);
    ClimbedPlaces climbedPlacesClimberTwo =
        ClimbedPlaces(climberName: user.secondClimberName);

    DidActivities didActivitiesClimberOne =
        DidActivities(climberName: user.firstClimberName);
    DidActivities didActivitiesClimberTwo =
        DidActivities(climberName: user.secondClimberName);

    PausedHandler pausedHandler =
        PausedHandler(isPausedUsed: false, isPaused: false);

    final TeamResults teamResults = TeamResults();

    try {
      final Map<dynamic, dynamic> data = dataSnapshot.value! as Map;
      data.forEach((key, value) {
        if (key == "points") {
          points = value;
        } else if (key == "start") {
          start = value;
        } else if (key == "pauseHandler") {
          final Map pauseMap = value as Map<dynamic, dynamic>;
          DateTime pauseOverTime = DateTime.now();
          bool isPaused = false;
          bool isPausedUsed = false;

          pauseMap.forEach((key, value) {
            switch (key) {
              case ("pauseOverTime"):
                {
                  pauseOverTime = DateTime.parse(value);
                  break;
                }
              case ("isPausedUsed"):
                {
                  isPausedUsed = value;
                  break;
                }
            }
          });

          if (DateTime.now().isBefore(pauseOverTime)) {
            isPaused = true;
          } else {
            isPaused = false;
          }

          pausedHandler = PausedHandler(
              isPausedUsed: isPausedUsed,
              isPaused: isPaused,
              pauseOverTime: pauseOverTime,);
        } else if (key == "Climbs") {
          firstClimberList.clear();
          secondClimberList.clear();
          final Map climbersMap = value as Map<dynamic, dynamic>;
          climbersMap.forEach((nameKey, value) {
            final Map placeMap = value as Map<dynamic, dynamic>;
            final String climberNameHere = nameKey;
            String placeName = "";
            placeMap.forEach((key, value) {
              placeName = key;
              final ClimbedPlace climbedPlace =
                  ClimbedPlace.fromSnapshot(value, placeName);

              if (climberNameHere == user.firstClimberName) {
                firstClimberList.add(climbedPlace);
              } else {
                secondClimberList.add(climbedPlace);
              }
            });
          });
          climbedPlacesClimberOne = ClimbedPlaces(
              climberName: user.firstClimberName,
              climbedPlaceList: firstClimberList,);
          climbedPlacesClimberTwo = ClimbedPlaces(
              climberName: user.secondClimberName,
              climbedPlaceList: secondClimberList,);
        } else if (key == "Activities") {
          final Map activitiesMap = value as Map<dynamic, dynamic>;
          activitiesMap.forEach((key, value) {
            if (key == user.firstClimberName) {
              didActivitiesClimberOne = DidActivities.fromSnapshot(value, key);
            } else {
              didActivitiesClimberTwo = DidActivities.fromSnapshot(value, key);
            }
          });
        }
        //Important! Currently, since adding extra Team points are done by hand in Firebase, the sum points have to be update as well!
        else if (key == "Teams") {
          final Map teamsMap = value as Map<dynamic, dynamic>;
          teamsMap.forEach((key, value) {
            final TeamResults teamResultsInside = TeamResults.fromJSON(value);
            teamResults.teamResultList.addAll(teamResultsInside.teamResultList);
          });
        }
      });

      results = Results(
          points: points,
          start: start,
          climberOneResults: climbedPlacesClimberOne,
          climberTwoResults: climbedPlacesClimberTwo,
          climberOneActivities: didActivitiesClimberOne,
          climberTwoActivities: didActivitiesClimberTwo,
          pausedHandler: pausedHandler,
          teamResults: teamResults,);
    } catch (error) {
      // Handle any potential errors here
    }
  }

  static Future<Places> getPlacesWithRoutes() async {
    final List<Sector> placesList = [];
    final DatabaseReference routesRef = FirebaseDatabase.instance.ref("Routes");

    try {
      final DatabaseEvent event = await routesRef.once();
      final DataSnapshot snapshot = event.snapshot;
      final Map data = snapshot.value! as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        final Sector place = Sector.fromSnapshot(key as String, value);
        placesList.add(place);
      });
    } catch (error) {
      // Handle any potential errors here
    }

    return Places(placeList: placesList);
  }

  static Future<Activities> getActivities() async {
    final List<Category> categoryList = [];
    final DatabaseReference activitiesRef =
        FirebaseDatabase.instance.ref("Activities");
    try {
      final DatabaseEvent event = await activitiesRef.once();
      final DataSnapshot snapshot = event.snapshot;
      final Map data = snapshot.value! as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        final Category category = Category.fromSnapshot(key as String, value);
        categoryList.add(category);
      });
    } catch (error) {
      // Handle any potential errors here
    }

    return Activities(categoryList: categoryList);
  }

  static Future<Category> getOnlyClimbersActivities() async {
    final List<Activity> activityList = [];
    final DatabaseReference activitiesRef =
        FirebaseDatabase.instance.ref("Activities");
    try {
      final DatabaseEvent event = await activitiesRef.child("Climbers").once();
      final DataSnapshot snapshot = event.snapshot;
      final Map data = snapshot.value! as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        final Activity activity = Activity.fromSnapshot(key as String, value);
        activityList.add(activity);
      });
    } catch (error) {
      // Handle any potential errors here
    }

    return Category(name: "Climbers", activityList: activityList);
  }
}
