import "dart:convert";

import "package:kisgeri24/data/dto/result_dto.dart";
import "package:kisgeri24/data/dto/team_result_dto.dart";
import "package:kisgeri24/data/models/result.dart";
import "package:kisgeri24/data/models/team_result.dart";

class TeamResultToTeamResultDtoConverter extends Converter<TeamResult, TeamResultDto> {
  final Converter<Result, ResultDto> _resultConverter;

  TeamResultToTeamResultDtoConverter(this._resultConverter);

  @override
  TeamResultDto convert(TeamResult input) {
    return TeamResultDto(
      input.teamId,
      input.results.map(
        (key, value) => MapEntry(key, _resultConverter.convert(value)),
      ),
    );
  }
}
