import "package:kisgeri24/data/dto/route_equipment.dart";

class RouteDto {
  final String _name;
  final String _grade;
  final double _points;
  final RouteEquipment _equipment;

  RouteDto(this._name, this._grade, this._points, this._equipment);

  RouteEquipment get equipment => _equipment;

  double get points => _points;

  String get grade => _grade;

  String get name => _name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteDto &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _grade == other._grade &&
          _points == other._points &&
          _equipment == other._equipment;

  @override
  int get hashCode =>
      _name.hashCode ^ _grade.hashCode ^ _points.hashCode ^ _equipment.hashCode;

  @override
  String toString() {
    return "RouteDto{_name: $_name, _grade: $_grade, _points: $_points, _equipment: $_equipment}";
  }
}
