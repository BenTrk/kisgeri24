import "package:kisgeri24/data/dto/result_dto.dart";

class TeamResultDto {
  final String _teamId;
  final Map<String, ResultDto> _results;

  TeamResultDto(this._teamId, this._results);

  Map<String, ResultDto> get results => _results;

  String get teamId => _teamId;

  @override
  String toString() {
    return "TeamResultDto{teamId: $_teamId, results: $_results}";
  }
}
