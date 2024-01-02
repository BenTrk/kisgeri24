import "dart:convert";

import "package:kisgeri24/data/dto/climbing_type.dart";
import "package:kisgeri24/data/dto/route_result_dto.dart";
import "package:kisgeri24/data/models/route_result.dart";
import "package:kisgeri24/misc/init_values.dart";

class RouteResultToRouteResultDtoConverter
    extends Converter<RouteResult, RouteResultDto> {
  @override
  RouteResultDto convert(RouteResult input) {
    return RouteResultDto(
      input.routeId,
      ClimbingType.fromString(input.type),
      input.timestamp ?? unsetInt,
    );
  }
}
