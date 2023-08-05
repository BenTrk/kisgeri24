import 'package:bloc/bloc.dart';
import 'package:kisgeri24/classes/results.dart';

// Define the events that can be triggered in the Bloc
abstract class ResultsEvent {}

class UpdateResultsEvent extends ResultsEvent {
  final Results newResults;

  UpdateResultsEvent(this.newResults);
}
