import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kisgeri24/services/helper.dart';

import '../../../constants.dart';
import '../../../model/user.dart';

class DateTimePickerModel{
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('Results');

  writeDateToDatabase(BuildContext context, String dateTime, User user) async {
    //Some error, investigate!
    await firestore
      .collection(usersCollection)
      .doc(user.userID)
      .update({'isStartDateSet' : true})
      .then((document) => showSnackBar(context, 'Start date is set!'));
    
    await ref.child(user.userID).set({
      "start": dateTime,
      "points": 0,
    });
  }

  setDateTime(int teamHours, int teamMinutes, String teamDate){
    String teamHoursString;
    String teamMinutesString;
    if (teamHours < 10){
      teamHoursString = '0$teamHours';
    } else {teamHoursString = '$teamHours';}
    if (teamMinutes < 10){
      teamMinutesString = '0$teamMinutes';
    } else {teamMinutesString = '$teamMinutes';}

    String teamStartTime = '$teamHoursString:$teamMinutesString';
        if (teamDate == dates[0]) {
          teamDate = '2023-07-01';
        } else {
          teamDate = '2023-07-02';
        }
        return '$teamDate - $teamStartTime';
  }
}