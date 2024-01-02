import "dart:convert";

import "package:kisgeri24/data/dto/activity_result_dto.dart";
import "package:kisgeri24/data/dto/result_dto.dart";
import "package:kisgeri24/data/dto/route_result_dto.dart";
import "package:kisgeri24/data/models/activity_result.dart";
import "package:kisgeri24/data/models/result.dart";
import "package:kisgeri24/data/models/route_result.dart";

class ResultToResultDtoConverter extends Converter<Result, ResultDto> {
  final Converter<RouteResult, RouteResultDto> _routeResultConverter;

  final Converter<ActivityResult, ActivityResultDto> _activityResultConverter;

  ResultToResultDtoConverter(
      this._routeResultConverter, this._activityResultConverter);

  @override
  ResultDto convert(Result input) {
    return ResultDto(
      input.routes.values
          .map((routeResult) => _routeResultConverter.convert(routeResult))
          .toList(),
      input.activities.values
          .map((activityResult) => _activityResultConverter.convert(activityResult))
          .toList(),
    );
  }
}
