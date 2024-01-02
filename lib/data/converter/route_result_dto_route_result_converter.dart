import "dart:convert";

import "package:kisgeri24/data/dto/route_result_dto.dart";
import "package:kisgeri24/data/models/route_result.dart";

class RouteResultDtoToRouteResultConverter
    extends Converter<RouteResultDto, RouteResult> {
  @override
  RouteResult convert(RouteResultDto input) {
    return RouteResult(
      input.routeId,
      input.type.shorthand,
      input.timestamp,
    );
  }
}
