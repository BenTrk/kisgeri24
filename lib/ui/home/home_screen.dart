

import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kisgeri24/classes/acivities.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/misc/cards/activities_card.dart';
import 'package:kisgeri24/misc/customMenu.dart';
import 'package:kisgeri24/model/init.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/authenticate.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';
import 'package:kisgeri24/ui/home/model/home_model.dart';
import '../../classes/place.dart';
import '../../classes/places.dart';
import '../../classes/rockroute.dart';
import '../../misc/background_task.dart';
import '../../misc/cards/card.dart';
import '../../publics.dart';
import 'date_time_picker_screen.dart';


//User is not refreshed!
class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen(
    {Key? key, required this.user}
    ) : super(key: key);

  @override
  State createState() => _HomeState();
}

enum SelectedItem { places, activities }

class _HomeState extends State<HomeScreen> {
  late User user;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  //Places state vars
  Place? selectedPlace;
  bool isPlaceSelected = false;
  //Activities state vars
  Category? selectedCategory;
  bool isCategorySelected = false;
  HomeModel homeModel = HomeModel();
  
  late DatabaseReference resultsRef;
  StreamSubscription<DatabaseEvent>? _streamSubscription;

  bool isTimeToClimb = false;

  //Enum for the Places/activites toggle button
  SelectedItem selectedItem = SelectedItem.places;

  //State handler for places
  void handlePlaceSelected(Place place) {
      setState(() {
        selectedPlace = place;
        isPlaceSelected = true;
      });
  }

  //Backbutton for both Places and Activities
  void handleBackButtonPressed() {
    setState(() {
      selectedPlace = null;
      isPlaceSelected = false;
      selectedCategory = null;
      isCategorySelected = false;
    });
  }

  void checkIfInRange(User user) async {
    bool isIn = await init.checkDateTime(user);
    if (isIn) {
      setState(() {
        isTimeToClimb = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
    checkIfInRange(user);
    resultsRef = FirebaseDatabase.instance.ref('Results').child(user.userID);
    _streamSubscription = resultsRef.onValue.listen((event) {
      init.getResults(user, event.snapshot);
      if (!isTimeToClimb){
        //Have to check, might get initialized with empty results! (But how can that be if I listen here for CHANGES in the db, i dunno.)
        BackgroundTask(user: user).startCheckAuthStateWhenOutOfDateRange(results, context);
        //For testing: Set dates[], dateTimePickerModel - teamdate, database - compStart and EndTime
      }
    });
    //if outOfTimeRange
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        log(state.authState.toString());
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        } 
        else if (state.authState == AuthState.didNotSetTime) {
          pushAndRemoveUntil(context, DateTimePickerScreen(user: user), false);
        } //add check for dateOutOfRange or create new screen for that. Add it to launcher.

        //implemented, remove to test it out!
        else if (state.authState == AuthState.authenticated) {
          setState(() {
            isTimeToClimb = true;
          });
          startBackGroundTasksForNotifications(user);
        }
      },

      child: StreamBuilder(
        stream: resultsRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
              //child: CircularProgressIndicator(),
          }
          return Scaffold(
        key: scaffoldKey,
        body: ListView(
          children: <Widget>[
            
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Menu inside :)
                  HomeScreenTitleWidget(user: user),
                  
                  const Padding(
                    padding: EdgeInsets.only(left:25.0, right: 25.0, bottom: 10),
                    child: Divider( color: Color.fromRGBO(255, 186, 0, 1),),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(user.teamName, style: const TextStyle(color: Color(colorPrimary), fontSize: 16, fontWeight: FontWeight.w600)),
                                       Text(
                                        !results.pausedHandler.isPaused
                                          ? 'End time: ${init.getEndDate(user, results.start)}'
                                          : "On Pause!"
                                      
                                  ),
                                    Text('Points: ${results.points}'),
                                ]
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //This should be disabled when isPausedUsed is true in database
                              ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: const Color(colorPrimary)),
                                    onPressed: () {
                                      !results.pausedHandler.isPausedUsed
                                      ? pauseCards()
                                      : showAlreadyUsedPauseError();
                                    },
                                    child: Text(results.pausedHandler.isPaused ? 'Time Paused' : 'Pause Time', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                              ),
                                  

                              const SizedBox(width: 10,),

                              ToggleButtons(
                                fillColor: const Color(colorPrimary),
                                selectedColor: Colors.white,
                                color: const Color(colorPrimary),
                                selectedBorderColor: const Color(colorPrimary),
                                borderColor: const Color(colorPrimary),
                                borderRadius: BorderRadius.circular(5),
                                // List of booleans to specify whether each button is selected or not
                                isSelected: [
                                  selectedItem == SelectedItem.places,
                                  selectedItem == SelectedItem.activities,
                                ],
                                // Callback when the user taps on a button
                                onPressed: (index) {
                                  setState(() {
                                    // Update the selectedItem based on the button tapped
                                    selectedItem = index == 0 ? SelectedItem.places : SelectedItem.activities;
                                  });
                                },
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text('Places'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text('Activities'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  
                  isPlaceSelected || isCategorySelected
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(colorPrimary),
                              ),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white,),
                                onPressed: handleBackButtonPressed,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : const SizedBox(),
                  isTimeToClimb
                  ?
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 250,
                    child: selectedItem == SelectedItem.places
                    ? DisplayPlacesAndRoutesWidget(
                      selectedPlace: selectedPlace,
                      isPlaceSelected: isPlaceSelected,
                      onPlaceSelected: handlePlaceSelected,
                      onBackButtonPressed: handleBackButtonPressed,
                      user: user,
                    )
                    : DisplayActivitiesWidget(
                      user: user,
                    ),
                  )
                  :
                  const Text('It\'s not the time to climb yet.')
                ],
              ),
            ),
          ],
        ),
      );
  }));
}

  void startBackGroundTasksForNotifications(User user) async {
      //For iOS it has to be set! Create an App... part: https://learn.microsoft.com/en-us/dotnet/maui/ios/capabilities?tabs=vs
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const initializationSettingsAndroid = AndroidInitializationSettings('logo');
      const initializationSettingsIOS = DarwinInitializationSettings();
      const initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      BackgroundTask(user: user).startHalfTimeNotificationsTask(flutterLocalNotificationsPlugin);
      BackgroundTask(user: user).startOneHourLeftNotificationsTask(flutterLocalNotificationsPlugin);
      BackgroundTask(user: user).startTenMinutesLeftNotificationsTask(flutterLocalNotificationsPlugin);
    }
  
  
  showAlreadyUsedPauseError() {
    showSnackBar(context, "You already used Pause.");
  }

  pauseCards() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attention!'),
          content: const Text('Are you sure you want to proceed? This will pause your climbing time and you won\'t be able to document climbs.'
           '1 hour later you can continue climbing. You can use this function only once during the competition.'),
          actions: [
            // Button to cancel the action and pop the dialog
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            // Button to proceed with the action
            TextButton(
              onPressed: () {
                //ToDo: if DateTime.now() - teamEndTime < 1 hours -> show error
                homeModel.writePauseInformation(DateTime.now(), user, context);
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

class DisplayActivitiesWidget extends StatelessWidget {
  final User user;

  const DisplayActivitiesWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
      return FutureBuilder<Category>(
        future: HomeModel.getOnlyClimbersCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.activityList.length,
              itemBuilder: (context, index) {
                Activity activity = snapshot.data!.activityList[index];
                return ActivitiesCard(
                        title: activity.name,
                        valueMap: activity.points,
                        user: user,
                        category: 'Climbers',
                      );
                    },
                  );
              }
        }
      );
  }
}

class DisplayPlacesAndRoutesWidget extends StatelessWidget {
  final Place? selectedPlace;
  final bool isPlaceSelected;
  final Function(Place) onPlaceSelected;
  final VoidCallback onBackButtonPressed;
  final User user;

  const DisplayPlacesAndRoutesWidget({super.key, 
    required this.selectedPlace,
    required this.isPlaceSelected,
    required this.onPlaceSelected,
    required this.onBackButtonPressed,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedPlace == null) {
      return FutureBuilder<Places>(
        future: HomeModel.getPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.placeList.length,
              itemBuilder: (context, index) {
                Place place = snapshot.data!.placeList[index];
                return GestureDetector(
                  onTap: () => onPlaceSelected(place),
                  child: Card(
                    color: const Color(colorPrimary),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(width: 4, height: 4,),
                        ListTile(
                          leading: const Icon(
                            Icons.done,
                            color: Colors.white),
                          title: Text(
                            place.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),),
                        ),
                        const SizedBox(width: 4, height: 4,),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      );
    } else {
      // Display the list of routes for the selected Place here
      return ListView.builder(
        itemCount: selectedPlace!.routeList.length,
        itemBuilder: (context, index) {
          RockRoute route = selectedPlace!.routeList[index];
          return CustomCard(
            title: route.name,
            diffchanger: route.diffchanger,
            difficultyNum: route.difficulty,
            user: user,
          );
        },
      );
    }
  }
}

class HomeScreenTitleWidget extends StatelessWidget {
  final User user;

  const HomeScreenTitleWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Row(
        children: [ 
          Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 48.0, right: 24.0, left: 24.0),
                        child: 
                        Row(
                          children: [
                            
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'assets/images/welcome_image.png',
                              alignment: Alignment.center,
                              width: 75.0,
                              height: 75.0,
                              fit: BoxFit.cover,
                              ),
                            ),

                            const Expanded(
                              child: Text(
                                "We did some climbing. Let's document it!",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 186, 0, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),),
                            ),

                          ]
                        )
                      ),
                      CustomMenu(contextFrom: context, user: user),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}