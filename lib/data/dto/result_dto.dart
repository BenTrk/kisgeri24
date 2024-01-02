import "package:kisgeri24/data/dto/activity_result_dto.dart";
import "package:kisgeri24/data/dto/route_result_dto.dart";

class ResultDto {
  final List<RouteResultDto> _routes;
  final List<ActivityResultDto> _activities;

  ResultDto(
    List<RouteResultDto>? routes,
    List<ActivityResultDto>? activityResults,
  )   : _routes = routes ?? [],
        _activities = activityResults ?? [];

  List<ActivityResultDto> get activities => _activities;

  List<RouteResultDto> get routes => _routes;

  @override
  String toString() {
    return "ResultDto{routes: $_routes, activities: $_activities}";
  }
}
