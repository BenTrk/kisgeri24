import 'package:kisgeri24/data/models/event.dart';
import 'package:kisgeri24/misc/init_values.dart';

class Challenge extends Event {
  Map<String, double> points;

  Challenge(String id, String yearId, String name, int startTime, int endTime,
      String? details, this.points)
      : super(id, yearId, name, startTime, endTime, details) {
    if (points.isEmpty) {
      throw ArgumentError('The points of the challenge cannot be empty!');
    }
  }

  @override
  factory Challenge.fromJson(Map<String, dynamic> parsedJson) {
    Map<String, double> points =
        _getPointsFromJson(parsedJson['points'] as Map<String, dynamic>);
    return Challenge(
        parsedJson['id'] ?? unsetString,
        parsedJson['yearId'] ?? unsetString,
        parsedJson['name'] ?? unsetString,
        parsedJson['startTime'] ?? unsetInt,
        parsedJson['endTime'] ?? unsetInt,
        parsedJson['details'] ?? unsetString,
        points);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'yearId': yearId,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'details': details,
      'points': points
    };
  }

  static Map<String, double> _getPointsFromJson(
      Map<String, dynamic> parsedJson) {
    Map<String, double> pointsMap = {};
    parsedJson.forEach((key, value) {
      pointsMap[key] = _convertPoint(value);
    });
    return pointsMap;
  }

  static double _convertPoint(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      throw ArgumentError('The value is not a number!');
    }
  }

  @override
  String toString() {
    return 'Challenge{id: $id, yearId: $yearId, name: $name, startTime: $startTime, endTime: $endTime, details: $details, points: $points}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Challenge &&
          runtimeType == other.runtimeType &&
          points == other.points;

  @override
  int get hashCode => super.hashCode ^ points.hashCode;

  static Challenge createWithExtraIdField(
      Map<String, dynamic> data, String id) {
    Challenge challenge = Challenge.fromJson(data);
    challenge.id = id;
    return challenge;
  }
}
