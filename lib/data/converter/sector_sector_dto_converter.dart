import "dart:convert";

import "package:kisgeri24/data/dto/route_dto.dart";
import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/dto/wall_dto.dart";
import "package:kisgeri24/data/models/route.dart";
import "package:kisgeri24/data/models/sector.dart";
import "package:kisgeri24/data/models/wall.dart";
import "package:kisgeri24/logging.dart";

class SectorToSectorDtoConverter extends Converter<Sector, SectorDto> {
  final Converter<Route, RouteDto> routeConverter;

  SectorToSectorDtoConverter(this.routeConverter);

  @override
  SectorDto convert(Sector input) {
    logger.d("Converting Sector [$input] to its corresponding DTO");
    final List<WallDto> walls = [];
    List<RouteDto> routes = [];
    if (input.walls == null || input.walls!.isEmpty) {
      if (input.routes != null) {
        for (final Route route in input.routes!) {
          routes.add(routeConverter.convert(route));
        }
      }
      walls.add(WallDto(input.name, routes));
    } else {
      for (final Wall wall in input.walls!) {
        for (final Route route in wall.routes) {
          routes.add(routeConverter.convert(route));
        }
        walls.add(WallDto(wall.name, routes));
        routes = [];
      }
    }
    return SectorDto(input.name, walls);
  }
}
