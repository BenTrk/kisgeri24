import "dart:convert";

import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/dto/route_equipment.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/logging.dart";

class RouteToRouteDtoConverter extends Converter<Route, RouteDto> {
  @override
  RouteDto convert(Route input) {
    logger.d("Converting Route [$input] to its corresponding DTO");
    return RouteDto(
      input.name,
      input.difficulty.toString() + input.diffchanger,
      input.points,
      RouteEquipment
          .bolted, // TODO: the designated collection has to be updated with this value (issue #101)
    );
  }
}
