import "package:kisgeri24/data/models/entity.dart";
import "package:kisgeri24/data/models/result.dart";

class TeamResult extends Entity {
  final String _teamId;
  final Map<String, Result> _results;

  TeamResult(this._teamId, this._results);

  Map<String, Result> get results => _results;

  String get teamId => _teamId;

  @override
  String toString() {
    return "TeamResult{teamId: $_teamId, results: $_results}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamResult &&
          runtimeType == other.runtimeType &&
          _teamId == other._teamId &&
          _results == other._results;

  @override
  int get hashCode => _teamId.hashCode ^ _results.hashCode;

  Map<String, dynamic> toJson() {
    return _results.map((key, value) => MapEntry(key, value.toJson()));
  }

  factory TeamResult.fromJson(String documentId, Map<String, dynamic> map) {
    return TeamResult(
      documentId,
      map as Map<String, Result>,
      //map["results"] as Map<String, Result>,
    );
  }
}
