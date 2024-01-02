import "dart:convert";

import "package:kisgeri24/data/converter/activity_result_dto_activity_result_converter.dart";
import "package:kisgeri24/data/converter/route_result_dto_route_result_converter.dart";
import "package:kisgeri24/data/dto/result_dto.dart";
import "package:kisgeri24/data/models/activity_result.dart";
import "package:kisgeri24/data/models/result.dart";
import "package:kisgeri24/data/models/route_result.dart";

class ResultDtoToResultConverter extends Converter<ResultDto, Result> {
  final RouteResultDtoToRouteResultConverter _routeResultConverter;

  final ActivityResultDtoToActivityResultConverter _activityResultConverter;

  ResultDtoToResultConverter(
      this._routeResultConverter, this._activityResultConverter);

  @override
  Result convert(ResultDto input) {
    final Map<String, RouteResult> routeResults = {};
    for (final routeResult in input.routes) {
      routeResults[routeResult.routeId] =
          _routeResultConverter.convert(routeResult);
    }
    final Map<String, ActivityResult> activityResults = {};
    for (final activityResult in input.activities) {
      activityResults[activityResult.activityId] =
          _activityResultConverter.convert(activityResult);
    }
    return Result(
      routeResults,
      activityResults,
    );
  }
}
