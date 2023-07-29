import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/services/helper.dart';

import '../../../constants.dart';
import '../../../model/user.dart';

class DateTimePickerModel{
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  writeDateToDatabase(BuildContext context, dateTime, User user) async {
    //Some error, investigate!
    return await firestore
      .collection(usersCollection)
      .doc(user.userID)
      .update({'startDate' : dateTime})
      .then((document) => showSnackBar(context, 'Start date is set!'));
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