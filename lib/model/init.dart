import 'package:firebase_database/firebase_database.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/misc/exceptions.dart';

import '../classes/places.dart';

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

      //Just for testing!
      if (DateTime.now().isBefore(compStartDateTime) || DateTime.now().isAfter(userEndDateTime)){
        isInRange = false;
      } else { isInRange = true; }

    } else {
      throw customException.noSnapshotException();
    }

  return isInRange;
  }

//ToDo
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




}