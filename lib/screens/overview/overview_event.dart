part of 'overview_bloc.dart';

abstract class OverviewEvent extends Equatable {
  const OverviewEvent();
}

class LoadDataEvent extends OverviewEvent {
  const LoadDataEvent();

  @override
  List<Object> get props => [];
}