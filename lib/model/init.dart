import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_screen/classes/user_details.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter_login_screen/misc/exceptions.dart';

class init{

  static UserDetails getUserDetails(){
    UserDetails userDetails = UserDetails();
    return userDetails;
  } 

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
}