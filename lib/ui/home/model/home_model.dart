import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kisgeri24/misc/database_writes.dart';
import 'package:kisgeri24/publics.dart';

import '../../../classes/acivities.dart';
import '../../../classes/places.dart';
import 'package:kisgeri24/model/init.dart';

import '../../../misc/background_task.dart';
import '../../../data/models/user.dart';

class HomeModel {
  DatabaseWrites databaseWrites = DatabaseWrites();
  BuildContext? _context;

  static Future<Places> getPlaces() async {
    places = await Init.getPlacesWithRoutes();
    return places;
  }

  static Future<Activities> getActivities() async {
    activities = await Init.getActivities();
    return activities;
  }

  static Future<Category> getOnlyClimbersCategory() async {
    climbersCategory = await Init.getOnlyClimbersActivities();
    return climbersCategory;
  }

  void writePauseInformation(
      DateTime pauseTime, User user, BuildContext context) async {
    //For iOS it has to be set! Create an App... part: https://learn.microsoft.com/en-us/dotnet/maui/ios/capabilities?tabs=vs
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid = AndroidInitializationSettings('logo');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _context = context;

    BackgroundTask(user: user)
        .startBackgroundTask(flutterLocalNotificationsPlugin, _context!);
    DateTime pauseOverTime = pauseTime.add(const Duration(hours: 1));
    databaseWrites.writePauseInformation(pauseOverTime, user);
  }
}
