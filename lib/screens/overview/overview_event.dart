part of "overview_bloc.dart";

abstract class OverviewEvent extends Equatable {
  const OverviewEvent();
}

class LoadDataEvent extends OverviewEvent {
  LoadDataEvent();

  LoadDataEvent.withTimer(this.timer);

  int? timer;

  @override
  List<Object> get props => [];
}
