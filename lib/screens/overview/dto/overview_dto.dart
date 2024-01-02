import "package:kisgeri24/data/dto/challenge_view.dart";
import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/notification/user_notification.dart";

class OverviewDto {
  final int? started;
  final List<SectorDto> sectors;
  final int teamPoints;
  final List<TeamNotification> notifications;
  final List<ChallengeView> challenges;
  final int? endTime;

  OverviewDto(this.started, this.sectors, this.teamPoints, this.notifications,
      this.challenges, this.endTime);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverviewDto &&
          runtimeType == other.runtimeType &&
          started == other.started &&
          sectors == other.sectors &&
          teamPoints == other.teamPoints &&
          notifications == other.notifications &&
          challenges == other.challenges &&
          endTime == other.endTime;

  @override
  int get hashCode =>
      started.hashCode ^
      sectors.hashCode ^
      teamPoints.hashCode ^
      notifications.hashCode ^
      challenges.hashCode ^
      endTime.hashCode;

  @override
  String toString() {
    return "OverviewDto{started: $started, sectors: $sectors, "
        "teamPoints: $teamPoints, notifications: $notifications, "
        "challenges: $challenges, endTime: $endTime}";
  }
}
