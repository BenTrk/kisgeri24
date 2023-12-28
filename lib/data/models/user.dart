import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kisgeri24/data/models/entity.dart';

class User extends Entity {
  String email;

  String firstClimberName;

  String secondClimberName;

  String userID;

  String teamName;

  String category;

  String appIdentifier;

  bool isStartDateSet;

  String? tenantId;

  String yearId;

  bool enabled;

  User({
    this.email = '',
    this.firstClimberName = '',
    this.secondClimberName = '',
    this.userID = '',
    this.teamName = '',
    this.category = '',
    this.isStartDateSet = false,
    this.tenantId,
    this.yearId = '',
    this.enabled = false,
  }) : appIdentifier =
            'Flutter Login Screen ${kIsWeb ? 'Web' : Platform.operatingSystem}';

  String getTeamName() => teamName;

  bool isEnabled() => enabled;

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        firstClimberName: parsedJson['firstClimberName'] ?? '',
        secondClimberName: parsedJson['secondClimberName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        teamName: parsedJson['teamName'] ?? '',
        category: parsedJson['category'] ?? '',
        tenantId: parsedJson['tenantId'],
        yearId: parsedJson['yearId'] ?? '',
        enabled: parsedJson['isEnabled'],
        isStartDateSet: parsedJson['isStartDateSet'] ?? false);
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
      'isStartDateSet': isStartDateSet,
      'tenantId': tenantId,
      'isEnabled': enabled,
      'yearId': yearId
    };
  }

  bool equals(User? user) =>
      user != null &&
      user.toJson().entries.every((entry) =>
          toJson().containsKey(entry.key) &&
          toJson()[entry.key] == entry.value);

  @override
  String toString() {
    return '{"email": "$email", "firstClimberName": "$firstClimberName", "secondClimberName": "$secondClimberName", "id": "$userID", "teamName": "$teamName", "category": "$category", "appIdentifier": "$appIdentifier", "isStartDateSet": "$isStartDateSet"}';
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
    if (userData.containsKey('startDate')) {
      isStartDateSet = userData['isStartDateSet'] ?? false;
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
