import "dart:convert";

import "package:kisgeri24/data/dto/result_dto.dart";
import "package:kisgeri24/data/dto/team_result_dto.dart";
import "package:kisgeri24/data/models/result.dart";
import "package:kisgeri24/data/models/team_result.dart";

class TeamResultDtoToTeamResultConverter extends Converter<TeamResultDto, TeamResult> {
  final Converter<ResultDto, Result> _resultConverter;

  TeamResultDtoToTeamResultConverter(this._resultConverter);

  @override
  TeamResult convert(TeamResultDto input) {
    return TeamResult(
      input.teamId,
      input.results.map(
        (key, value) => MapEntry(key, _resultConverter.convert(value)),
      ),
    );
  }
}
