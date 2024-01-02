import "dart:convert";

import "package:kisgeri24/data/dto/result_dto.dart";
import "package:kisgeri24/data/dto/team_result_dto.dart";
import "package:kisgeri24/data/models/result.dart";
import "package:kisgeri24/data/models/route_result.dart";
import "package:kisgeri24/data/models/team_result.dart";
import "package:kisgeri24/data/repositories/result_repository.dart";
import "package:kisgeri24/logging.dart";

class ResultService {
  final ResultRepository _resultRepository;

  final Converter<TeamResult, TeamResultDto> _resultToResultDtoConverter;

  final Converter<TeamResultDto, TeamResult>
      _teamResultDtoToTeamResultConverter;

  ResultService(
    this._resultRepository,
    this._resultToResultDtoConverter,
    this._teamResultDtoToTeamResultConverter,
  );

  Future<void> saveResult(TeamResultDto result) async {
    await _resultRepository.save(
      _teamResultDtoToTeamResultConverter.convert(result),
    );
  }

  Future<void> updateResult(TeamResultDto result) async {
    await _resultRepository
        .update(_teamResultDtoToTeamResultConverter.convert(result));
  }

  Future<void> update(TeamResultDto teamResultDto) async {
    final TeamResult teamResult =
        _teamResultDtoToTeamResultConverter.convert(teamResultDto);
    teamResult.results.forEach((competitorName, individualResult) {
      individualResult.routes.forEach((routeId, routeResult) {
        _resultRepository.updateRouteResult(
          teamResult.teamId,
          routeId,
          competitorName,
          routeResult,
        );
        // TODO: do the same for the activity results
      });
    });
  }

  Future<TeamResultDto?> getResultByTeamId(String teamId) async {
    final TeamResult? result =
        await _resultRepository.getResultsByTeamId(teamId);
    return result == null ? null : _resultToResultDtoConverter.convert(result);
  }
}
