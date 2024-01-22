import 'package:kisgeri24/data/dto/challenge_view.dart';

class ChallengeDto extends ChallengeView {
  final String _yearId;

  final int _endTime;

  final String? _details;

  ChallengeDto(String id, String name, Map<String, double> points, this._yearId,
      int startTime, this._endTime, this._details)
      : super(id, name, startTime, points);

  String? get details => _details;

  int get endTime => _endTime;

  String get yearId => _yearId;
}
