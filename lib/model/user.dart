import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:kisgeri24/constants.dart';

class User {
  String email;

  String firstClimberName;

  String secondClimberName;

  String userID;

  String teamName;

  String category;

  bool isPaid;

  String appIdentifier;

  String startDate;

  User(
      {this.email = '',
      this.firstClimberName = '',
      this.secondClimberName = '',
      this.userID = '',
      this.teamName = '',
      this.category = '',
      this.isPaid = false,
      this.startDate = ('1969-07-20 - 20:18'),
      })
      : appIdentifier =
            'Flutter Login Screen ${kIsWeb ? 'Web' : Platform.operatingSystem}';   
        

  String getTeamName() => teamName;

  String getStartDate() => startDate;
  

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        firstClimberName: parsedJson['firstClimberName'] ?? '',
        secondClimberName: parsedJson['secondClimberName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        teamName: parsedJson['teamName'] ?? '',
        category: parsedJson['category'] ?? '',
        isPaid: parsedJson['isPaid'] ?? false,
        startDate: parsedJson['startDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstClimberName': firstClimberName,
      'secondClimberName': secondClimberName,
      'id': userID,
      'teamName': teamName,
      'category': category,
      'isPaid': isPaid,
      'appIdentifier': appIdentifier,
      'startDate' : startDate
    };
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
    if (userData.containsKey('isPaid')) {
      isPaid = userData['isPaid'];
    }
    if (userData.containsKey('startDate')) {
      startDate = userData['startDate'] ?? defaultDateTime;
    }
  }
}
