import "package:kisgeri24/data/dto/climbing_type.dart";

class RouteResultDto {
  String routeId;
  ClimbingType type;
  int timestamp;

  RouteResultDto(this.routeId, this.type, this.timestamp);

  @override
  String toString() {
    return "RouteResultDto{routeId: $routeId, type: $type, "
        "timestamp: $timestamp}";
  }
}
