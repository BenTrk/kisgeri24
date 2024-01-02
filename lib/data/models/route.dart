import "package:kisgeri24/data/models/entity.dart";
import "package:kisgeri24/misc/init_values.dart";

class Route extends Entity {
  String name;
  String id;
  double points;
  int length;
  int key;
  int ordinal;
  int difficulty;
  String equipment;
  String diffchanger;

  Route({
    String? name,
    String? id,
    double? points,
    int? length,
    int? key,
    int? ordinal,
    int? difficulty,
    String? equipment,
    String? diffchanger,
  })  : name = name ?? unsetString,
        id = id ?? unsetString,
        points = points ?? 0,
        length = length ?? 0,
        key = key ?? 0,
        ordinal = ordinal ?? unsetInt,
        difficulty = difficulty ?? 0,
        equipment = equipment ?? unsetString,
        diffchanger = diffchanger ?? unsetString;

  static Route fromSnapshot(Map<String, dynamic> value) {
    String name = unsetString;
    String id = unsetString;
    double points = 0.0;
    int length = 0;
    int routeKey = 0;
    int ordinal = unsetInt;
    int difficulty = 0;
    String equipment = unsetString;
    String diffchanger = unsetString;

    value.forEach((key, value) {
      if (key == "name") {
        name = value;
      } else if (key == "id") {
        id = value;
      } else if (key == "points") {
        points = (value as int).toDouble();
      } else if (key == "length") {
        length = value;
      } else if (key == "key") {
        routeKey = value;
      } else if (key == "ordinal") {
        ordinal = value as int;
      } else if (key == "difficulty") {
        difficulty = value;
      } else if (key == "equipment") {
        equipment = value;
      } else if (key == "diffchanger") {
        diffchanger = value;
      }
    });

    return Route(
      name: name,
      id: id,
      points: points,
      length: length,
      key: routeKey,
      ordinal: ordinal,
      difficulty: difficulty,
      equipment: equipment,
      diffchanger: diffchanger,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Route &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          points == other.points &&
          length == other.length &&
          key == other.key &&
          difficulty == other.difficulty &&
          equipment == other.equipment &&
          diffchanger == other.diffchanger;

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      points.hashCode ^
      length.hashCode ^
      key.hashCode ^
      difficulty.hashCode ^
      equipment.hashCode ^
      diffchanger.hashCode;

  @override
  String toString() {
    return "Route{name: $name}";
  }
}
