import "package:kisgeri24/data/dto/wall_dto.dart";

class SectorDto {
  final String name;
  final List<WallDto> walls;

  SectorDto(this.name, this.walls);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectorDto &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          walls == other.walls;

  @override
  int get hashCode => name.hashCode ^ walls.hashCode;

  @override
  String toString() {
    return "SectorDto{name: $name, walls: $walls}";
  }
}
