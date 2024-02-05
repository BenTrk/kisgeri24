import "package:kisgeri24/data/dto/route_equipment.dart";

class RouteDto {
  final String _name;
  final int _ordinal;
  final String _grade;
  final double _points;
  final RouteEquipment _equipment;

  RouteDto(
      this._name, this._ordinal, this._grade, this._points, this._equipment);

  RouteEquipment get equipment => _equipment;

  double get points => _points;

  String get grade => _grade;

  String get name => _name;

  int get ordinal => _ordinal;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteDto &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _ordinal == other._ordinal &&
          _grade == other._grade &&
          _points == other._points &&
          _equipment == other._equipment;

  @override
  int get hashCode =>
      _name.hashCode ^
      _ordinal.hashCode ^
      _grade.hashCode ^
      _points.hashCode ^
      _equipment.hashCode;

  @override
  String toString() {
    return "RouteDto{_name: $_name, _ordinal: $_ordinal, _grade: $_grade, _points: $_points, _equipment: $_equipment}";
  }
}
