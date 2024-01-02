part of "overview_bloc.dart";

abstract class OverviewState extends Equatable {
  const OverviewState();
}

class OverviewInitial extends OverviewState {
  @override
  List<Object> get props => [];
}

class LoadingState extends OverviewState {
  @override
  List<Object> get props => [];
}

class LoadedState extends OverviewState {
  final OverviewDto data;

  const LoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class ErrorState extends OverviewState {
  final String errorMessage;

  const ErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
