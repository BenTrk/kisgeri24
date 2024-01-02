import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/misc/init_values.dart';
import 'package:kisgeri24/logging.dart';

class Year extends Entity {
  String id;

  int year;

  String tenantId;

  int? compStart;

  int? compEnd;

  Year(this.id, this.year, this.tenantId);

  Year.all(this.id, this.year, this.tenantId, this.compStart, this.compEnd);

  factory Year.fromJson(Map<String, dynamic> parsedJson) {
    logger.d('Creating Year instance based on the input JSON: $parsedJson');
    return Year.all(
        parsedJson['id'] ?? unsetString,
        parsedJson['year'] ?? unsetString,
        parsedJson['tenantId'] ?? unsetString,
        parsedJson['compStart'],
        parsedJson['compEnd']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year': year,
      'tenantId': tenantId,
      'compStart': compStart,
      'compEnd': compEnd
    };
  }

  bool equals(Year? user) =>
      user != null &&
      user.toJson().entries.every((entry) =>
          toJson().containsKey(entry.key) &&
          toJson()[entry.key] == entry.value);

  @override
  String toString() {
    return 'Year{id: $id, year: $year, tenantId: $tenantId compStart: $compStart, compEnd: $compEnd}';
  }

  void updateFromMap(Map<String, dynamic> yearData) {
    if (yearData.containsKey('compStart')) {
      year = yearData['compStart'];
    }
    if (yearData.containsKey('compEnd')) {
      year = yearData['compEnd'];
    }
  }
}
