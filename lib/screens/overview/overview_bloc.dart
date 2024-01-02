import "dart:async";
import "dart:convert";

import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:firebase_core/firebase_core.dart";
import "package:kisgeri24/data/converter/activity_result_activity_result_dto_converter.dart";
import "package:kisgeri24/data/converter/activity_result_dto_activity_result_converter.dart";
import "package:kisgeri24/data/converter/result_dto_result_converter.dart";
import "package:kisgeri24/data/converter/result_result_dto_converter.dart";
import "package:kisgeri24/data/converter/route_result_dto_route_result_converter.dart";
import "package:kisgeri24/data/converter/route_result_route_result_dto_converter.dart";
import "package:kisgeri24/data/converter/route_route_dto_converter.dart";
import "package:kisgeri24/data/converter/sector_sector_dto_converter.dart";
import "package:kisgeri24/data/converter/team_result_dto_team_result_converter.dart";
import "package:kisgeri24/data/converter/team_result_team_result_dto_converter.dart";
import "package:kisgeri24/data/converter/year_year_dto_converter.dart";
import "package:kisgeri24/data/dto/challenge_view.dart";
import "package:kisgeri24/data/dto/climbing_type.dart";
import "package:kisgeri24/data/dto/result_dto.dart";
import "package:kisgeri24/data/dto/route_result_dto.dart";
import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/dto/team_result_dto.dart";
import "package:kisgeri24/data/models/sector.dart";
import "package:kisgeri24/data/models/user.dart";
import "package:kisgeri24/data/models/year.dart";
import "package:kisgeri24/data/notification/user_notification.dart";
import "package:kisgeri24/data/repositories/challenge_repository.dart";
import "package:kisgeri24/data/repositories/result_repository.dart";
import "package:kisgeri24/data/repositories/sector_repository.dart";
import "package:kisgeri24/data/repositories/year_repository.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/screens/overview/dto/overview_dto.dart";
import "package:kisgeri24/services/authenticator.dart";
import "package:kisgeri24/services/challenge_service.dart";
import "package:kisgeri24/services/firebase_service.dart";
import "package:kisgeri24/services/result_service.dart";
import "package:kisgeri24/services/sector_service.dart";
import "package:kisgeri24/services/year_service.dart";

part "overview_event.dart";

part "overview_state.dart";

const sleepDuration = Duration(seconds: 1);

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final Converter<Sector, SectorDto> sectorToSectorDtoConverter =
  SectorToSectorDtoConverter(RouteToRouteDtoConverter());

  OverviewBloc() : super(OverviewInitial()) {
    on<LoadDataEvent>((event, emit) async {
      await _load(timerStarted: event.timer == null).then((value) {
        emit(value);
      });
    });
  }

  Future<OverviewState> _load({bool? timerStarted = false}) async {
    try {
      final List<SectorDto> routes = await fetchSectors();
      final int userPoints = await fetchTeamPoints();
      final notifications = await fetchNotifications();
      final challenges = await fetchChallenges();
      const endTime = 0;

      await _createTestResult(create: true);

      final overviewData = OverviewDto(
        null,
        routes,
        userPoints,
        notifications,
        challenges,
        endTime,
      );

      return LoadedState(overviewData);
    } on FirebaseException catch (fbException) {
      logger.e(
        "Failed to fetch data: $fbException",
        error: fbException,
        stackTrace: fbException.stackTrace,
      );
      return ErrorState("Failed to fetch data: \n${fbException.message}");
    } catch (error) {
      logger.e("Something has happened: \n$error", error: error);
      return ErrorState("Something has happened: \n$error");
    }
  }

  Future<List<SectorDto>> fetchSectors() async {
    final List<SectorDto> sectors = await SectorService(
      SectorRepository(
        FirebaseSingletonProvider.instance.firestoreInstance,
      ),
      SectorToSectorDtoConverter(
        RouteToRouteDtoConverter(),
      ),
    ).getSectorsWithRoutes(ordered: true);
    logger.d("${sectors.length} SectorDto got converted and about to return");
    return Future.value(sectors);
  }

  Future<int> fetchTeamPoints() {
    logger.d("collecting team points");
    return Future.value(1234);
  }

  Future<List<TeamNotification>> fetchNotifications() {
    logger.d("collecting notifications");
    return Future.value([]);
  }

  Future<List<ChallengeView>> fetchChallenges() {
    logger.d("collecting challenges");
    return ChallengeService(
      ChallengeRepository(
        FirebaseSingletonProvider.instance.firestoreInstance,
      ),
    ).getViewsByYear("kzU99Z2APtOBhvNFgPvv");
  }

  Future<int?> getRemainingTimeIfTimerStarted() async {
    logger.d("calculating remaining time");
    final Year yearData = await YearService(
      YearRepository(
        FirebaseSingletonProvider.instance.firestoreInstance,
      ),
      YearToYearDtoConverter(),
    ).getYearByTenantId(
      "kzU99Z2APtOBhvNFgPvv",
    ); // TODO: remove hardcoded tenantId
    final User? currentUser = await Auth(
      FirebaseSingletonProvider.instance.authInstance,
      FirebaseSingletonProvider.instance.firestoreInstance,
    ).getAuthUser();
    if (currentUser != null) {
      logger.d(
        "current user is: $currentUser who has the start time of ${currentUser
            .startTime}",
      );
      final int remainingTime = yearData.compEnd! - currentUser.startTime;
      logger.d("remaining time is: $remainingTime");
      return remainingTime;
    }
    return Future.value();
  }

  Future<void> _createTestResult({bool create = false}) async {
    if (create) {
      logger.d("Creating test result");
      const String teamId = "q1BY1obVmb4jkxMQ0jTpSYl6Albg";

      final resultService = ResultService(
        ResultRepository(FirebaseSingletonProvider.instance.database),
        TeamResultToTeamResultDtoConverter(
          ResultToResultDtoConverter(
            RouteResultToRouteResultDtoConverter(),
            ActivityResultToActivityResultDtoConverter(),
          ),
        ),
        TeamResultDtoToTeamResultConverter(
          ResultDtoToResultConverter(
            RouteResultDtoToRouteResultConverter(),
            ActivityResultDtoToActivityResultConverter(),
          ),
        ),
      );

      final TeamResultDto teamResultForYuli = TeamResultDto(teamId, {
        "Yuli": ResultDto(
          [
            RouteResultDto(
              "64F84B53-6838-451D-B7BD-1066AB6403ED",
              ClimbingType.lead,
              -1,
            ),
          ],
          null,
        ),
      });

      await resultService.saveResult(teamResultForYuli);

      logger.d("Current team result: "
          "${await resultService.getResultByTeamId(teamId)}");

      await Future.delayed(sleepDuration);

      teamResultForYuli.results["Yuli"]!.routes
          .where((element) =>
      element.routeId == "64F84B53-6838-451D-B7BD-1066AB6403ED",)
          .first
          .type = ClimbingType.topRope;

      await resultService.updateResult(teamResultForYuli);

      logger.d("Current team result: "
          "${await resultService.getResultByTeamId(teamId)}");

      await Future.delayed(sleepDuration);

      final TeamResultDto resultForSanyi = TeamResultDto(
        teamId,
        {
          "Sanyi": ResultDto(
            [
              RouteResultDto(
                "64F84B53-6838-451D-B7BD-1066AB6403ED",
                ClimbingType.lead,
                -1,
              ),
            ],
            null,
          ),
        },
      );

      logger.d("Saving result for Sanyi");

      await resultService.saveResult(resultForSanyi);

      await Future.delayed(sleepDuration);

      teamResultForYuli.results["Yuli"]!.routes.add(
        RouteResultDto(
          "64F84B53-6838-451D-B7BD-123123123",
          ClimbingType.lead,
          -1,
        ),
      );

      await resultService.updateResult(teamResultForYuli);
    }
  }
}
