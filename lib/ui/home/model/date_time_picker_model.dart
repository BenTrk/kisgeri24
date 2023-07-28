import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/services/helper.dart';
import 'package:flutter_login_screen/ui/home/date_time_picker_screen.dart';

import '../../../constants.dart';
import '../../../model/user.dart';

class DateTimePickerModel{
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  writeDateToDatabase(BuildContext context, dateTime, User user) async {
    //Some error, it does not cause huge thing.
    return await firestore
      .collection(usersCollection)
      .doc(user.userID)
      .update({'startDate' : dateTime})
      .then((document) => showSnackBar(context, 'Start date is set!'));
  }
}