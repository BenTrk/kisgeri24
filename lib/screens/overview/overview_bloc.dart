import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kisgeri24/data/notification/user_notification.dart';
import 'package:kisgeri24/screens/overview/overview_dto.dart';

part 'overview_event.dart';

part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  OverviewBloc() : super(OverviewInitial()) {
    on<OverviewEvent>((event, emit) {
      // TODO: implement
    });

    Future<List<Route>> fetchRoutes() async {
      return Future.value([]);
    }

    Future<int> fetchUserPoints() async {
      return Future.value(0);
    }

    Future<List<UserNotification>> fetchNotifications() async {
      return Future.value([]);
    }

    @override
    Stream<OverviewState> mapEventToState(OverviewEvent event) async* {
      if (event is LoadDataEvent) {
        yield LoadingState();

        try {
          final routes = await fetchRoutes();
          final userPoints = await fetchUserPoints();
          final notifications = await fetchNotifications();

          final combinedData = OverviewDto(routes, userPoints, notifications);

          yield LoadedState(
              combinedData); // Emit LoadedState with aggregated data
        } catch (error) {
          yield ErrorState('Failed to fetch data: $error');
        }
      }
    }
  }

  void loadData() {
    add(const LoadDataEvent());
  }
}
