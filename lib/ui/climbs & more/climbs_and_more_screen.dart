
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/classes/acivities.dart';
import 'package:kisgeri24/misc/cards/check_activity_card.dart';
import 'package:kisgeri24/misc/customMenu.dart';
import 'package:kisgeri24/model/init.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';
import 'package:kisgeri24/ui/climbs%20&%20more/climbs_and_more_model.dart';
import '../../blocs & events & states/results_bloc.dart';
import '../../classes/results.dart';
import '../../constants.dart';
import '../../misc/cards/check_climb_card.dart';
import '../../publics.dart';
import '../home/date_time_picker_screen.dart';

typedef RemoveClimbedRouteCallback = void Function(Object climbOrActivity, User user, String climberName, String placeName);

class ClimbsAndMoreScreen extends StatefulWidget {
  final User user;

  const ClimbsAndMoreScreen(
    {Key? key, required this.user}
    ) : super(key: key);

  @override
  State createState() => _ClimbsAndMoreScreenState();
}

enum SelectedClimber { climberOne, climberTwo }
enum SelectedItem { places, activities }

class _ClimbsAndMoreScreenState extends State<ClimbsAndMoreScreen> {
  late User user;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPlaceSelected = false;
  ClimbedPlace? selectedPlace;
  Category? selectedCategory;
  bool isCategorySelected = false;
  ClimbsAndMoreModel climbsAndMoreModel = ClimbsAndMoreModel();
  late List<String> climbers;

  SelectedClimber selectedClimber = SelectedClimber.climberOne;
  SelectedItem selectedItem = SelectedItem.places;

  void handleBackButtonPressed() {
    setState(() {
      selectedPlace = null;
      isPlaceSelected = false;
      selectedCategory = null;
      isCategorySelected = false;
    });
  }

  //State handler for places
  void handlePlaceSelected(ClimbedPlace place) {
      setState(() {
        selectedPlace = place;
        isPlaceSelected = true;
      });
  }


  @override
  void initState() {
    super.initState();
    user = widget.user;
    climbers = [user.firstClimberName, user.secondClimberName];
  }

  @override
  void dispose() {
    BlocProvider.of<ResultsBloc>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        } else if (state.authState == AuthState.didNotSetTime) {
          pushAndRemoveUntil(context, DateTimePickerScreen(user: user), false);
        } //add check for dateOutOfRange or create new screen for that. Add it to launcher.
      },
      child: BlocProvider<ResultsBloc>(
      create: (context) => ResultsBloc(user),
      child: BlocBuilder<ResultsBloc, Results>(
      builder: (context, results) {
          return Scaffold(
            key: scaffoldKey,
            body: ListView(
              children: <Widget>[
                
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
        
                      ClimbsAndMoreScreenTitleWidget(user: user),
                      
                      const Padding(
                        padding: EdgeInsets.only(left:25.0, right: 25.0, bottom: 10),
                        child: Divider( color: Color.fromRGBO(255, 186, 0, 1),),
                      ),
        
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(user.teamName, style: const TextStyle(color: Color(colorPrimary), fontSize: 16, fontWeight: FontWeight.w600)),
                              Text('Started at: ${results.start}'),
                              Text('Points: ${results.points}'),
                            ]
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToggleButtons(
                            fillColor: const Color(colorPrimary),
                            selectedColor: Colors.white,
                            color: const Color(colorPrimary),
                            selectedBorderColor: const Color(colorPrimary),
                            borderColor: const Color(colorPrimary),
                            borderRadius: BorderRadius.circular(5),
                            // List of booleans to specify whether each button is selected or not
                            isSelected: [
                              selectedClimber == SelectedClimber.climberOne,
                              selectedClimber == SelectedClimber.climberTwo,
                            ],
                            // Callback when the user taps on a button
                            onPressed: (index) {
                              setState(() {
                              // Update the selectedItem based on the button tapped
                              selectedClimber = index == 0 ? SelectedClimber.climberOne : SelectedClimber.climberTwo;
                              log(selectedClimber.name);
                              });
                            },
                            children: [
                              Text(user.firstClimberName),
                              Text(user.secondClimberName),
                            ],
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
        
                      const SizedBox(height: 16,),
                      
                      isPlaceSelected ||isCategorySelected
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
                      
                      SizedBox(
                        width: 0.9 * MediaQuery.of(context).size.width,
                        height: 300,
                        child: selectedItem == SelectedItem.places
                        ? DisplayClimbedRoutes(selectedPlace: selectedPlace, isPlaceSelected: isPlaceSelected, onPlaceSelected: handlePlaceSelected, 
                              onBackButtonPressed: handleBackButtonPressed, climberName: climbers[selectedClimber.index], user: user)
                        : DisplayDidActivities(climberName: climbers[selectedClimber.index], user: user,)
                      ),

                    ],
                  ),
                ),
              ],
            ),
          );
        }
      )
    )
    );
  }
}

class DisplayDidActivities extends StatelessWidget {
  String climberName;
  User user;

  DisplayDidActivities(
    {
      super.key,
      required this.climberName,
      required this.user
    }
  );

  @override
  Widget build(BuildContext context) {
    //Will it update itself when a climb is removed?
    DidActivities didActivities = ClimbsAndMoreModel.getDidActivities(climberName);
    return ListView.builder(
            itemCount: didActivities.activitiesList.length,
            itemBuilder: (context, index) {
              DidActivity didActivity = didActivities.activitiesList[index];
              return CheckActivitiesCard(didActivity: didActivity, user: user, climberName: climberName,);
            },
          );
        }
  }


class DisplayClimbedRoutes extends StatelessWidget {
  String climberName;
  final VoidCallback onBackButtonPressed;
  final Function(ClimbedPlace) onPlaceSelected;
  final ClimbedPlace? selectedPlace;
  final bool isPlaceSelected;
  User user;

  DisplayClimbedRoutes(
    {
      super.key,
      required this.climberName,
      required this.user,
      required this.selectedPlace,
      required this.isPlaceSelected,
      required this.onPlaceSelected,
      required this.onBackButtonPressed,
    }
  );

  @override
  Widget build(BuildContext context) {

    return BlocProvider<ResultsBloc>(
      create: (context) => ResultsBloc(user),
      child: BlocBuilder<ResultsBloc, Results>(
      builder: (context, results) {

    ClimbedPlaces climbedPlaces;
              if (results.climberOneResults.climberName == climberName){
                  climbedPlaces = results.climberOneResults;
                } else {
                  climbedPlaces = results.climberTwoResults;
                }
    //Same question as above
    if (selectedPlace == null && climbedPlaces.climbedPlaceList.isNotEmpty) {
    return ListView.builder(
            itemCount: climbedPlaces.climbedPlaceList.length,
            itemBuilder: (context, index) {
              ClimbedPlace place = climbedPlaces.climbedPlaceList[index];
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
        } else if (selectedPlace != null && climbedPlaces.climbedPlaceList.isNotEmpty) {
          // Display the list of routes for the selected Place here
              ClimbedPlace routesPlace = results.climberOneResults.getClimbedPlace(selectedPlace!.name);
              log('routename:' + routesPlace.name + ' ' + selectedPlace!.name);
              return ListView.builder(
                itemCount: routesPlace.climbedRouteList.length,
                itemBuilder: (context, index) {
                  ClimbedRoute route = routesPlace.climbedRouteList[index];
                  return CheckClimbedPlaceCard(climbedRoute: route, user: user, climberName: climberName, placeName: selectedPlace!.name,);
                },
              );
        } else {
          return Text('No climbs yet.');
        }
  }));
}
}

  


class ClimbsAndMoreScreenTitleWidget extends StatelessWidget {
  final User user;

  const ClimbsAndMoreScreenTitleWidget({
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
                  "Awesome team with awesome results!",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 186, 0, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),),
                        ),

                          ]
                        )
                      ),
                      CustomMenu(user: user),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}