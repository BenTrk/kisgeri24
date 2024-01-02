class ActivityResultDto {
  final String _activityId;

  final double _points;

  final String? _resultTitle;

  ActivityResultDto(this._activityId, this._points, this._resultTitle);

  String? get resultTitle => _resultTitle;

  double get points => _points;

  String get activityId => _activityId;

  @override
  String toString() {
    return "ActivityResultDto{_activityId: $_activityId, _points: $_points,"
        " _resultTitle: $_resultTitle}";
  }
}
