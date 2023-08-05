import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kisgeri24/blocs%20&%20events%20&%20states/results_events.dart';
import 'package:kisgeri24/classes/results.dart';
import 'package:kisgeri24/publics.dart';
import '../model/user.dart';

class ResultsBloc extends Bloc<ResultsEvent, Results> {
  final _dataController = StreamController<Results>();
  Stream<Results> get dataStream => _dataController.stream;

  ResultsBloc(User user) : super(Results(points: 0, start: '')) {
    DatabaseReference resultsRef =
        FirebaseDatabase.instance.ref('Results').child(user.userID);
    num points = 0.0;
    String start = '';
    List<ClimbedPlace> firstClimberList = [];
    List<ClimbedPlace> secondClimberList = [];
    ClimbedPlaces climbedPlacesClimberOne =
        ClimbedPlaces(climberName: user.firstClimberName);
    ClimbedPlaces climbedPlacesClimberTwo =
        ClimbedPlaces(climberName: user.secondClimberName);
    DidActivities didActivitiesClimberOne =
        DidActivities(climberName: user.firstClimberName);
    DidActivities didActivitiesClimberTwo =
        DidActivities(climberName: user.secondClimberName);
    PausedHandler pausedHandler =
        PausedHandler(isPausedUsed: false, isPaused: false);

    try {
      resultsRef.onValue.listen((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        final Map data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (key == 'points') {
            points = value;
          } else if (key == "start") {
            start = value;
          } else if (key == "pauseHandler") {
            Map pauseMap = value as Map<dynamic, dynamic>;
            DateTime pauseOverTime = DateTime.now();
            bool isPaused = false;
            bool isPausedUsed = false;
            pauseMap.forEach((key, value) {
              switch (key) {
                case ("pauseOverTime"):
                  {
                    pauseOverTime = DateTime.parse(value);
                    break;
                  }
                case ("isPausedUsed"):
                  {
                    isPausedUsed = value;
                    break;
                  }
              }
            });

            if (DateTime.now().isBefore(pauseOverTime)) {
              isPaused = true;
            } else {
              isPaused = false;
            }

            pausedHandler =
                PausedHandler(isPausedUsed: isPausedUsed, isPaused: isPaused, pauseOverTime: pauseOverTime);
          } else if (key == "Climbs") {
            firstClimberList.clear();
            Map climbersMap = value as Map<dynamic, dynamic>;
            climbersMap.forEach((key, value) {
              Map placeMap = value as Map<dynamic, dynamic>;
              String climberNameHere = key;
              String placeName = '';
              placeMap.forEach((key, value) {
                placeName = key;
                final ClimbedPlace climbedPlace =
                    ClimbedPlace.fromSnapshot(value, placeName);

                if (climberNameHere == user.firstClimberName) {
                  firstClimberList.add(climbedPlace);
                } else {
                  secondClimberList.add(climbedPlace);
                }
              });
            });
            climbedPlacesClimberOne = ClimbedPlaces(
                climberName: user.firstClimberName, climbedPlaceList: firstClimberList);
            climbedPlacesClimberTwo = ClimbedPlaces(
                climberName: user.secondClimberName, climbedPlaceList: secondClimberList);
          } else if (key == "Activities") {
            Map activitiesMap = value as Map<dynamic, dynamic>;
            activitiesMap.forEach((key, value) {
              if (key == user.firstClimberName) {
                didActivitiesClimberOne = DidActivities.fromSnapshot(value, key);
              } else {
                didActivitiesClimberTwo = DidActivities.fromSnapshot(value, key);
              }
            });
          }
        });

        results = Results(points: points, start: start, climberOneActivities: didActivitiesClimberOne, climberTwoActivities: didActivitiesClimberTwo,
        climberOneResults: climbedPlacesClimberOne, climberTwoResults: climbedPlacesClimberTwo, pausedHandler: pausedHandler);

        // Update the state of the bloc with the fetched data
        emit(Results(
          points: points,
          start: start,
          climberOneResults: climbedPlacesClimberOne,
          climberTwoResults: climbedPlacesClimberTwo,
          climberOneActivities: didActivitiesClimberOne,
          climberTwoActivities: didActivitiesClimberTwo,
          pausedHandler: pausedHandler,
        ));
      });
    } catch (error) {
      // Handle any potential errors here
      print("Error fetching data: $error");
    }
  }
}
