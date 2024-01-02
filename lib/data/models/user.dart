import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/misc/init_values.dart';

class User extends Entity {
  String email;

  String firstClimberName;

  String secondClimberName;

  String userID;

  String teamName;

  String category;

  String appIdentifier;

  int startTime;

  String tenantId;

  String yearId;

  bool enabled;

  User(
      {this.email = unsetString,
      this.firstClimberName = unsetString,
      this.secondClimberName = unsetString,
      this.userID = unsetString,
      this.teamName = unsetString,
      this.category = unsetString,
      this.tenantId = unsetString,
      this.yearId = unsetString,
      this.enabled = false,
      this.startTime = unsetInt})
      : appIdentifier =
            'KisGeri24 - ${kIsWeb ? 'Web' : Platform.operatingSystem}';

  String getTeamName() => teamName;

  bool isEnabled() => enabled;

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? unsetString,
        firstClimberName: parsedJson['firstClimberName'] ?? unsetString,
        secondClimberName: parsedJson['secondClimberName'] ?? unsetString,
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? unsetString,
        teamName: parsedJson['teamName'] ?? unsetString,
        category: parsedJson['category'] ?? unsetString,
        tenantId: parsedJson['tenantId'],
        yearId: parsedJson['yearId'] ?? unsetString,
        enabled: parsedJson['isEnabled'],
        startTime: parsedJson['startTime'] ?? unsetInt);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstClimberName': firstClimberName,
      'secondClimberName': secondClimberName,
      'id': userID,
      'teamName': teamName,
      'category': category,
      'appIdentifier': appIdentifier,
      'tenantId': tenantId,
      'isEnabled': enabled,
      'yearId': yearId,
      'startTime': startTime,
    };
  }

  bool equals(User? user) =>
      user != null &&
      user.toJson().entries.every((entry) =>
          toJson().containsKey(entry.key) &&
          toJson()[entry.key] == entry.value);

  @override
  String toString() {
    return '{"email": "$email", "firstClimberName": "$firstClimberName", "secondClimberName": "$secondClimberName", "id": "$userID", "teamName": "$teamName", "category": "$category", "appIdentifier": "$appIdentifier", "startTime": "$startTime"}';
  }

  void updateFromMap(Map<String, dynamic> userData) {
    // Update the user instance with the new data from the userData map
    // If the keys exist in the userData map, update the corresponding properties in the user instance
    if (userData.containsKey('email')) {
      email = userData['email'];
    }
    if (userData.containsKey('firstClimberName')) {
      firstClimberName = userData['firstClimberName'];
    }
    if (userData.containsKey('secondClimberName')) {
      secondClimberName = userData['secondClimberName'];
    }
    if (userData.containsKey('id') || userData.containsKey('userID')) {
      userID = userData['id'] ?? userData['userID'];
    }
    if (userData.containsKey('teamName')) {
      teamName = userData['teamName'];
    }
    if (userData.containsKey('category')) {
      category = userData['category'];
    }
    if (userData.containsKey('startTime')) {
      startTime = userData['startTime'] ?? unsetInt;
    }
    if (userData.containsKey('tenantId')) {
      tenantId = userData['tenantId'];
    }
    if (userData.containsKey('isEnabled')) {
      enabled = userData['isEnabled'];
    }
    if (userData.containsKey('yearId')) {
      yearId = userData['yearId'];
    }
  }
}
