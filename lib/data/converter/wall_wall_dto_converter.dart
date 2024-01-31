import "dart:convert";

import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/dto/wall_dto.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/wall.dart";
import "package:kisgeri24/logging.dart";

class WallToWallDtoConverter extends Converter<Wall, WallDto> {
  final Converter<Route, RouteDto> routeConverter;

  WallToWallDtoConverter(this.routeConverter);

  @override
  WallDto convert(Wall input) {
    logger.d("Converting Wall [$input] to its corresponding DTO");
    return WallDto(
      input.name,
      input.routes.map((route) => routeConverter.convert(route)).toList(),
    );
  }
}
