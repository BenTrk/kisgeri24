import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kisgeri24/model/init.dart';

import '../classes/results.dart';
import '../model/authentication_bloc.dart';
import '../model/user.dart';

class BackgroundTask {
  User user;

  BackgroundTask({
    required this.user,
  });

  void startBackgroundTask(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, BuildContext context) {
    Future.delayed(const Duration(hours: 1), () async {
      init.getPauseOver(user, context);

      // Show a notification
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'kisgeri24_1',
        'pause_over',
        importance: Importance.max,
        priority: Priority.high,
      );
      const notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin.show(
        0,
        'It\'s Time to Climb Again!',
        'Pause is over, let\'s go and rock on!',
        notificationDetails,
      );
    });
  }

  //should be triggered right after the start time!
  void startHalfTimeNotificationsTask(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    int categoryTime = init.getCategoryTime(user); //To get the category num
    categoryTime = categoryTime / 2 as int; //Create function for get duration for 1 hour left, and 10 minutes left.
    Future.delayed(Duration(hours: categoryTime), () async {
      // Show a notification
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'kisgeri24_2',
        'half_time',
        importance: Importance.max,
        priority: Priority.high,
      );
      const notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin.show(
        0,
        'Way to go!',
        'You have reached half time, climb on!',
        notificationDetails,
      );
    });
  }

  //should be triggered right after the start time!
  void startOneHourLeftNotificationsTask(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    int categoryTime = init.getCategoryTime(user); //To get the category num
    categoryTime = init.getOneHourLeftDurationInHours(categoryTime);
    Future.delayed(Duration(hours: categoryTime), () async {
      // Show a notification
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'kisgeri24_3',
        'one_hour',
        importance: Importance.max,
        priority: Priority.high,
      );
      const notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin.show(
        0,
        'Time is ticking!',
        'One hour left, climb on!',
        notificationDetails,
      );
    });
  }

  //should be triggered right after the start time!
  void startTenMinutesLeftNotificationsTask(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    int categoryTime = init.getCategoryTime(user); //To get the category num
    categoryTime = init.getTenMinutesLeftDurationInMinutes(categoryTime);
    Future.delayed(Duration(minutes: categoryTime), () async {
      // Show a notification
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'kisgeri24_4',
        'ten_minutes',
        importance: Importance.max,
        priority: Priority.high,
      );
      const notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin.show(
        0,
        'Almost finished!',
        'You have ten minutes left, go climb on!',
        notificationDetails,
      );
    });
  }

  void startCheckAuthStateWhenOutOfDateRange(Results results, BuildContext context){
    String startTime = results.start;
    Duration duration = init.getTimeUntilStartTime(startTime);

    Future.delayed(duration, () async {
      context.read<AuthenticationBloc>().add(CheckAuthenticationEvent());
    });
  }
}