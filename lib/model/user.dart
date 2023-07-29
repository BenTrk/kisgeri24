import 'dart:io';
import 'package:flutter/foundation.dart';

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
}
