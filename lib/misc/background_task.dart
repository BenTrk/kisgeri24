import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kisgeri24/model/init.dart';

import '../model/user.dart';

class BackgroundTask {
  User user;
  BuildContext context;

  BackgroundTask({
    required this.user,
    required this.context,
  });

  void startBackgroundTask(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    Future.delayed(const Duration(hours: 1, seconds: 5), () async {
      init.getPauseOver(user, context);
      // Your code here to perform the desired action
      // For example, update the data and show a notification
      // This code will be executed every hour in the background

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
}