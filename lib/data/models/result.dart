import "package:kisgeri24/data/models/activity_result.dart";
import "package:kisgeri24/data/models/entity.dart";
import "package:kisgeri24/data/models/route_result.dart";
import "package:kisgeri24/logging.dart";

class Result extends Entity {
  final Map<String, RouteResult> _routes;

  final Map<String, ActivityResult> _activities;

  Result(
      Map<String, RouteResult>? routes, Map<String, ActivityResult>? activities)
      : _routes = routes ?? {},
        _activities = activities ?? {};

  Map<String, RouteResult> get routes => _routes;

  Map<String, ActivityResult> get activities => _activities;

  Map<String, dynamic> toJson() {
    return {
      "routes": _routes.map((key, value) => MapEntry(key, value.toJson())),
      "activities":
          _activities.map((key, value) => MapEntry(key, value.toMap())),
    };
  }

  factory Result.fromJson(Map<String, dynamic> map) {
    return Result(
      map["routes"] != null
          ? _getRouteResultMapFromInputMap(
              Map<String, dynamic>.from(map["routes"]),
            )
          : {},
      map["activities"] != null
          ? _getActivityResultMapFromInputMap(
              Map<String, dynamic>.from(map["activities"]),
            )
          : {},
    );
  }

  static Map<String, RouteResult> _getRouteResultMapFromInputMap(
    Map<String, dynamic> map,
  ) {
    return Map<String, RouteResult>.fromEntries(
      map.entries.map(
            (entry) => MapEntry(
              entry.key,
              RouteResult.fromMap(
                entry.key,
                Map<String, dynamic>.from(entry.value),
              ),
            ),
          ),
    );
  }

  static Map<String, ActivityResult> _getActivityResultMapFromInputMap(
    Map<String, dynamic> map,
  ) {
    return Map<String, ActivityResult>.fromEntries(
      map.entries.map(
            (entry) => MapEntry(
              entry.key,
              ActivityResult.fromMap(
                entry.key,
                Map<String, dynamic>.from(entry.value),
              ),
            ),
          ),
    );
  }
}
