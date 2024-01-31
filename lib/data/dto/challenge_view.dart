class ChallengeView {
  final String _id;
  final String _name;
  final int _startTime;
  final Map<String, double> _points;

  ChallengeView(this._id, this._name, this._startTime, this._points);

  int get startTime => _startTime;

  Map<String, double> get points => _points;

  String get name => _name;

  String get id => _id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengeView &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _name == other._name &&
          _startTime == other._startTime &&
          _points == other._points;

  @override
  int get hashCode =>
      _id.hashCode ^ _name.hashCode ^ _startTime.hashCode ^ _points.hashCode;

  @override
  String toString() {
    return "ChallengeView{_id: $_id, _name: $_name, _startTime: $_startTime, _points: $_points}";
  }
}
