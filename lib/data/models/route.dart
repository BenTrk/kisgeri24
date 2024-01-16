import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/data/models/init_values.dart';

class Route extends Entity {
  String name;
  String id;
  double points;
  int length;
  int key;
  int difficulty;
  String diffchanger;

  Route({
    String? name,
    String? id,
    double? points,
    int? length,
    int? key,
    int? difficulty,
    String? diffchanger,
  })  : name = name ?? unsetString,
        id = id ?? unsetString,
        points = points ?? 0,
        length = length ?? 0,
        key = key ?? 0,
        difficulty = difficulty ?? 0,
        diffchanger = diffchanger ?? unsetString;

  static Route fromSnapshot(value) {
    Map routeMap = value as Map<dynamic, dynamic>;
    String name = unsetString;
    String id = unsetString;
    double points = 0.0;
    int length = 0;
    int keyHere = 0;
    int difficulty = 0;
    String diffchanger = unsetString;

    routeMap.forEach((key, value) {
      if (key == 'name') {
        name = value;
      } else if (key == 'id') {
        id = value;
      } else if (key == 'points') {
        points = (value as int).toDouble();
      } else if (key == 'length') {
        length = value;
      } else if (key == 'key') {
        keyHere = value;
      } else if (key == 'difficulty') {
        difficulty = value;
      } else if (key == 'diffchanger') {
        diffchanger = value;
      }
    });

    Route route = Route(
        name: name,
        id: id,
        points: points,
        length: length,
        key: keyHere,
        difficulty: difficulty,
        diffchanger: diffchanger);
    return route;
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
          diffchanger == other.diffchanger;

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      points.hashCode ^
      length.hashCode ^
      key.hashCode ^
      difficulty.hashCode ^
      diffchanger.hashCode;

  @override
  String toString() {
    return 'Route{name: $name}';
  }
}
