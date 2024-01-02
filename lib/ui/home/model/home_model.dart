import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:kisgeri24/classes/acivities.dart";
import "package:kisgeri24/classes/places.dart";
import "package:kisgeri24/data/models/user.dart";
import "package:kisgeri24/misc/background_task.dart";
import "package:kisgeri24/misc/database_writes.dart";
import "package:kisgeri24/model/init.dart";
import "package:kisgeri24/publics.dart";

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

  Future<void> writePauseInformation(
      DateTime pauseTime, User user, BuildContext context,) async {
    //For iOS it has to be set! Create an App... part: https://learn.microsoft.com/en-us/dotnet/maui/ios/capabilities?tabs=vs
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid = AndroidInitializationSettings("logo");
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS,);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _context = context;

    BackgroundTask(user: user)
        .startBackgroundTask(flutterLocalNotificationsPlugin, _context!);
    final DateTime pauseOverTime = pauseTime.add(const Duration(hours: 1));
    await databaseWrites.writePauseInformation(pauseOverTime, user);
  }
}
