import 'package:kisgeri24/data/models/entity.dart';

class Route extends Entity {
  String name;
  double points;
  int length;
  int key;
  int difficulty;
  String diffchanger;

  Route({
    String? name,
    double? points,
    int? length,
    int? key,
    int? difficulty,
    String? diffchanger,
  })  : name = name ?? '',
        points = points ?? 0,
        length = length ?? 0,
        key = key ?? 0,
        difficulty = difficulty ?? 0,
        diffchanger = diffchanger ?? '';

  static Route fromSnapshot(value) {
    Map routeMap = value as Map<dynamic, dynamic>;
    String name = '';
    double points = 0;
    int length = 0;
    int keyHere = 0;
    int difficulty = 0;
    String diffchanger = '';

    routeMap.forEach((key, value) {
      if (key == 'name') {
        name = value;
      } else if (key == 'points') {
        points = double.parse(value.toString());
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
        points: points,
        length: length,
        key: keyHere,
        difficulty: difficulty,
        diffchanger: diffchanger);
    return route;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Route &&
        other.name == name &&
        other.points == points &&
        other.length == length &&
        other.key == key &&
        other.difficulty == difficulty &&
        other.diffchanger == diffchanger;
  }

  @override
  int get hashCode =>
      Object.hash(name, points, length, key, difficulty, diffchanger);

  @override
  String toString() {
    return 'Route{name: $name}';
  }
}
