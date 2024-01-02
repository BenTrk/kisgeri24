import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kisgeri24/screens/overview/overview_data_bundle.dart';

part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  OverviewBloc() : super(OverviewInitial()) {
    on<OverviewEvent>((event, emit) {
      // TODO: implement event handler
    });

    @override
    Stream<OverviewState> mapEventToState(OverviewEvent event) async* {
      if (event is LoadDataEvent) {
        yield LoadingState();

        try {
          final routes = await fetchRoutes();
          final userPoints = await fetchUserPoints();
          final notifications = await fetchNotifications();

          final combinedData = OverviewDataBundle(routes, userPoints, notifications);

          yield LoadedState(combinedData); // Emit LoadedState with aggregated data
        } catch (error) {
          yield ErrorState('Failed to fetch data: $error');
        }
      }
    }

    Future<List<Route>> fetchRoutes() async {
    }

    Future<List<Point>> fetchUserPoints() async {
    }

    Future<List<Notification>> fetchNotifications() async {
    }

    void loadData() {
      add(const LoadDataEvent());
    }

  }
}
