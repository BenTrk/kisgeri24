import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:kisgeri24/blocs%20&%20events%20&%20states/results_events.dart';
import 'package:kisgeri24/classes/results.dart';
import 'package:kisgeri24/publics.dart';

class ResultsBloc extends Bloc<ResultsEvent, Results> {
  ResultsBloc() : super(results) {
    on<UpdateResultsEvent>((event, emit) {
      // Handle the UpdateResultsEvent here
      // You can update the state and emit the new state using emit method
      log('UPDATED results');
      emit(event.newResults);
    });
  }
}