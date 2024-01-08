import 'package:kisgeri24/data/notification/user_notification.dart';

class OverviewDto {
  final List<Route> routes;
  final int teamPoints;
  final List<UserNotification> notifications;

  OverviewDto(this.routes, this.teamPoints, this.notifications);
}
