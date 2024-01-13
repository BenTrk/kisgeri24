import 'package:kisgeri24/data/models/init_values.dart';
import 'package:kisgeri24/logging.dart';

class Tier {
  final String _name;
  final double _points;

  Tier(this._name, this._points);

  factory Tier.fromJson(Map<String, dynamic> parsedJson) {
    logger.d('Creating Event instance based on the input JSON: $parsedJson');
    return Tier(
        parsedJson['name'] ?? unsetString, parsedJson['points'] ?? unsetDouble);
  }

  String get name => _name;

  double get points => _points;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tier &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _points == other._points;

  @override
  int get hashCode => _name.hashCode ^ _points.hashCode;

  @override
  String toString() {
    return 'Tier{_name: $_name, _points: $_points}';
  }
}
