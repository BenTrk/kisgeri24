import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/misc/exceptions.dart';

import '../classes/acivities.dart';
import '../classes/place.dart';
import '../classes/places.dart';
import '../classes/results.dart';

class init{
  //Compare starttime and starttime + category to start and end times
  //return true if in range, false, if out of range
  //Take extra care when adding dates for testing manually - the format is important

  //ToDo: Use try catch for dates, do not initialize on start for stupid values!
  static Future<bool> checkDateTime(User user) async {
    DatabaseReference basicRef = FirebaseDatabase.instance.ref('BasicData');
    DatabaseReference resultsRef = FirebaseDatabase.instance.ref('Results').child(user.userID);
    DateTime compStartDateTime = DateTime(1969,07,20,20,17);
    DateTime userStartDateTime = DateTime(1969,07,20,20,17);
    String userCategory = user.category;
    Duration duration = const Duration(hours: 0);
 
    final snapshot = await basicRef.get();
    if (snapshot.exists) {
      String compStartTime = snapshot.child('compStartTime').value.toString();

      compStartTime = compStartTime.replaceFirst(RegExp(' - '), 'T');
      compStartDateTime = DateTime.parse(compStartTime);
    } else {
      throw customException.noSnapshotException();
    }

    final snapshotResult = await resultsRef.get();
    if (snapshot.exists) {
      String userStartTime = snapshotResult.child('start').value.toString();
      userStartTime = userStartTime.replaceFirst(RegExp(' - '), 'T');
      userStartDateTime = DateTime.parse(userStartTime);
    } else {
      throw customException.noSnapshotException();
    }

    switch(userCategory) {
      case ('6H'): {
        duration = const Duration(hours: 6);
        break;
      }
      case ('12H'): {
        duration = const Duration(hours: 12);
        break;
      }
      case ('24H'): {
        duration = const Duration(hours: 24);
        break;
      }
    }

    DateTime userEndDateTime = userStartDateTime.add(duration);

    bool isInRange = false;
    if (DateTime.now().isBefore(compStartDateTime) || DateTime.now().isAfter(userEndDateTime)){
       isInRange = false;
    } else { isInRange = true; }

    return isInRange;
  }

  static getResults(User user, Results results) async {
    num points = 0.0;
    String start = '';
    List<ClimbedPlace> firstClimberList = [];
    List<ClimbedPlace> secondClimberList = []; 
    DatabaseReference resultsRef = FirebaseDatabase.instance.ref('Results').child(user.userID);

    final snapshotStart = await resultsRef.child('start').get();
    final snapshotPoints = await resultsRef.child('points').get();
    if (snapshotStart.exists && snapshotPoints.exists) {
      results.updatePointsAndStart(num.parse(snapshotPoints.value.toString()), snapshotStart.value as String);
    } else {
      print('No data available.');
    }

    try{
      resultsRef.onValue.listen((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        final Map data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if(key == 'points'){
            points = value;
          } 
          else if (key == "start") {
            start = value;
          } 
          else if (key == "Climbs") {
            Map climbersMap = value as Map<dynamic, dynamic>;
            climbersMap.forEach((key, value) {
              final ClimbedPlace climbedPlace = ClimbedPlace.fromSnapshot(key as String, value);
              if (key == user.firstClimberName){
                firstClimberList.add(climbedPlace);
              } 
              else {
                secondClimberList.add(climbedPlace);
              }
            });
          } 
          else if (key == "Activities") {
            //ToDo
          } 
        });
        results = Results(points: points, start: start);
        //TODO: updateResults();
       });
    } catch (error) {
      // Handle any potential errors here
      print("Error fetching data: $error");
    }
    return results;
  }

  static Future<Places> getPlacesWithRoutes() async {
  List<Place> placesList = [];
  DatabaseReference routesRef = FirebaseDatabase.instance.ref('Routes');

  try {
    DatabaseEvent event = await routesRef.once();
    DataSnapshot snapshot = event.snapshot;
    final Map data = snapshot.value as Map<dynamic, dynamic>;

    data.forEach((key, value) {
      final Place place = Place.fromSnapshot(key as String, value);
      placesList.add(place);
    });
  } catch (error) {
    // Handle any potential errors here
    print("Error fetching data: $error");
  }

  return Places(placeList: placesList);
  }

  static Future<Activities> getActivities() async{
    List<Category> categoryList = [];
    DatabaseReference activitiesRef = FirebaseDatabase.instance.ref('Activities');
    try {
      DatabaseEvent event = await activitiesRef.once();
      DataSnapshot snapshot = event.snapshot;
      final Map data = snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        final Category category = Category.fromSnapshot(key as String, value);
        categoryList.add(category);
      });
    } catch (error) {
      // Handle any potential errors here
      print("Error fetching data: $error");
    }

  return Activities(categoryList: categoryList);
  }
}