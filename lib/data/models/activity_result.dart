import "package:kisgeri24/data/models/entity.dart";

class ActivityResult extends Entity {

  final String _activityId;

  final double _points;

  final String? _resultTitle;

  ActivityResult(this._activityId, this._points, this._resultTitle);

  String? get resultTitle => _resultTitle;

  double get points => _points;

  String get activityId => _activityId;

  Map<String, dynamic> toMap() {
    return {
      "activityId": _activityId,
      "points": _points,
      "resultTitle": _resultTitle,
    };
  }

  factory ActivityResult.fromMap(String id, Map<String, dynamic> map) {
    return ActivityResult(
      id,
      map["points"] as double,
      map["resultTitle"] as String,
    );
  }
}