import "package:kisgeri24/data/dto/wall_dto.dart";

class SectorDto {
  final String name;
  final int ordinal;
  final List<WallDto> walls;

  SectorDto(this.name, this.ordinal, this.walls);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectorDto &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          ordinal == other.ordinal &&
          walls == other.walls;

  @override
  int get hashCode => name.hashCode ^ ordinal.hashCode ^ walls.hashCode;

  @override
  String toString() {
    return "SectorDto{name: $name, ordinal: $ordinal, walls: $walls}";
  }
}
