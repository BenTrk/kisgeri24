import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kisgeri24/constants.dart';
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
  static Future<bool> checkDateTime(User user) async {
    DatabaseReference basicRef = FirebaseDatabase.instance.ref('BasicData');
    bool isInRange = false;

    final snapshot = await basicRef.get();
    if (snapshot.exists) {
      if (user.startDate == defaultDateTime.toString()){
        return true;
      }

      String compStartTime = snapshot.child('compStartTime').value.toString();

      compStartTime = compStartTime.replaceFirst(RegExp(' - '), 'T');
      DateTime compStartDateTime = DateTime.parse(compStartTime);

      String userStartTime = user.startDate.replaceFirst(RegExp(' - '), 'T');
      String userCategory = user.category;

      DateTime userStartDateTime = DateTime.parse(userStartTime);
      Duration duration = const Duration(hours: 0);
      
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

      if (DateTime.now().isBefore(compStartDateTime) || DateTime.now().isAfter(userEndDateTime)){
        isInRange = false;
      } else { isInRange = true; }

    } else {
      throw customException.noSnapshotException();
    }

  return isInRange;
  }

  static Future<DateTime> getEndDateTime(User user) async {
      String userStartTime = user.startDate.replaceFirst(RegExp(' - '), 'T');
      String userCategory = user.category;

      DateTime userStartDateTime = DateTime.parse(userStartTime);
      Duration duration = const Duration(hours: 0);
      
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

      return userStartDateTime.add(duration);
  }

  static getResults(User user, Results results) async {
    double points = 0;
    List<ClimbedPlace> firstClimberList = [];
    List<ClimbedPlace> secondClimberList = []; 
    DatabaseReference resultsRef = FirebaseDatabase.instance.ref('Results').child(user.userID);

    try{
      resultsRef.onValue.listen((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        final Map data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if(key == 'points'){
            points = value;
          } else if (key == "Climbs") {
            Map climbersMap = value as Map<dynamic, dynamic>;
            climbersMap.forEach((key, value) {
              final ClimbedPlace climbedPlace = ClimbedPlace.fromSnapshot(key as String, value);
              if (key == user.firstClimberName){
                firstClimberList.add(climbedPlace);
              } else {
                secondClimberList.add(climbedPlace);
              }
            });
          } else if (key == "Activities") {
            //ToDo
          } 
        });
        results = Results(points: points);
        //TODO: updateResults();
       });
    } catch (error) {
      // Handle any potential errors here
      print("Error fetching data: $error");
    }
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

  //Use this: https://firebase.google.com/docs/firestore/query-data/listen (this describes the afterlife too, how to use the data in a widget).
  static StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>
      listenToUserData(String userId, User userInstance) {
    // Return the StreamSubscription from the snapshots() method
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        // If the document exists, update the user instance with the new data
        var userData = snapshot.data();
        userInstance.updateFromMap(userData!);
      } else {
        // Handle the case when the document doesn't exist
        // You can choose to reset the user instance or take other actions
      }
    });
  }
}