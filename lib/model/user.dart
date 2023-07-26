import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  DateTime startDate;

  User(
      {this.email = '',
      this.firstClimberName = '',
      this.secondClimberName = '',
      this.userID = '',
      this.teamName = '',
      this.category = '',
      this.isPaid = false,
      Timestamp? startDate,
      })
      : appIdentifier =
            'Flutter Login Screen ${kIsWeb ? 'Web' : Platform.operatingSystem}',
        startDate = DateTime.utc(1969, 7, 20, 20, 18);    
        

  String getTeamName() => teamName;

  DateTime getStartDate() => startDate;
  

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        firstClimberName: parsedJson['firstClimberName'] ?? '',
        secondClimberName: parsedJson['secondClimberName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        teamName: parsedJson['teamName'] ?? '',
        category: parsedJson['category'] ?? '',
        isPaid: parsedJson['isPaid'] ?? false,
        startDate: parsedJson['startDate'] ?? DateTime.utc(1969, 7, 20, 20, 18));
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
