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
      input.ordinal,
      input.difficulty.toString() + input.diffchanger,
      input.points,
      RouteEquipment.fromString(input.equipment),
    );
  }
}
