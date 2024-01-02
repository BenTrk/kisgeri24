import "package:kisgeri24/data/models/entity.dart";

class RouteResult extends Entity {
  final String _routeId;
  final String _type;
  final int? _timestamp;

  RouteResult(this._routeId, this._type, this._timestamp);

  String get type => _type;

  String get routeId => _routeId;

  int? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    return {
      "type": _type,
      "timestamp": _timestamp,
    };
  }

  factory RouteResult.fromMap(String routeId, Map<String, dynamic> map) {
    return RouteResult(
      routeId,
      map["type"] as String,
      map["timestamp"] as int?,
    );
  }
}
