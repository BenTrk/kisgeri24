import "package:kisgeri24/data/dto/route_dto.dart";

class WallDto {
  final String name;
  final List<RouteDto> routes;

  WallDto(this.name, this.routes);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WallDto &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          routes == other.routes;

  @override
  int get hashCode => name.hashCode ^ routes.hashCode;

  @override
  String toString() {
    return "WallDto{name: $name, routes: $routes}";
  }
}
