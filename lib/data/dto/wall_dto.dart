import "package:kisgeri24/data/dto/route_dto.dart";

class WallDto {
  final String name;
  final int ordinal;
  final List<RouteDto> routes;

  WallDto(this.name, this.ordinal, this.routes);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WallDto &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          ordinal == other.ordinal &&
          routes == other.routes;

  @override
  int get hashCode => name.hashCode ^ ordinal.hashCode ^ routes.hashCode;

  @override
  String toString() {
    return "WallDto{name: $name, ordinal: $ordinal, routes: $routes}";
  }
}
