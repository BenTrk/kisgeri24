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
}
