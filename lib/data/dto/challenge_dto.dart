import "package:kisgeri24/data/dto/challenge_view.dart";

class ChallengeDto extends ChallengeView {
  final String _yearId;

  final int _endTime;

  final String? _details;

  ChallengeDto(
    String id,
    String name,
    Map<String, double> points,
    this._yearId,
    int startTime,
    this._endTime,
    this._details,
  ) : super(id, name, startTime, points);

  String? get details => _details;

  int get endTime => _endTime;

  String get yearId => _yearId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ChallengeDto &&
          runtimeType == other.runtimeType &&
          _yearId == other._yearId &&
          _endTime == other._endTime &&
          _details == other._details;

  @override
  int get hashCode =>
      super.hashCode ^ _yearId.hashCode ^ _endTime.hashCode ^ _details.hashCode;

  @override
  String toString() {
    return "ChallengeDto{_yearId: $_yearId, _endTime: $_endTime, _details: $_details}";
  }
}
