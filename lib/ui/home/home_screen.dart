
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/classes/acivities.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/misc/cards/activities_card.dart';
import 'package:kisgeri24/misc/customMenu.dart';
import 'package:kisgeri24/model/init.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';
import 'package:kisgeri24/ui/home/model/home_model.dart';
import '../../classes/place.dart';
import '../../classes/places.dart';
import '../../classes/results.dart';
import '../../classes/rockroute.dart';
import '../../misc/cards/card.dart';
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
  Results results = Results(points: 0.0, start: '');
  var scaffoldKey = GlobalKey<ScaffoldState>();
  //Places state vars
  Place? selectedPlace;
  bool isPlaceSelected = false;
  //Activities state vars
  Category? selectedCategory;
  bool isCategorySelected = false;
  //Time pause vars
  bool isPaused = false;
  DateTime? pauseTime;

  //Enum for the Places/activites toggle button
  SelectedItem selectedItem = SelectedItem.places;

  //State handler for places
  void handlePlaceSelected(Place place) {
    if (!isPaused) {
      setState(() {
        selectedPlace = place;
        isPlaceSelected = true;
      });
    }
  }

  //State handler for Activities
  void handleCategorySelected(Category category) {
    if (!isPaused){
      setState(() {
        selectedCategory = category;
        isCategorySelected = true;
      });
    }
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

  //State handler for pause function
  void pauseCards() {
    setState(() {
      isPaused = !isPaused;
      pauseTime = DateTime.now();
    });

    // Start a timer to reset the pause status after one hour
    Timer(Duration(hours: 1), () {
      setState(() {
        isPaused = false;
        pauseTime = null;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
    updateResult();
  }

  //Update results - check later, maybe wrong.
  Future<void> updateResult() async {
    Results newResults = await init.getResults(user, results);
    setState(() {
      results = newResults; // Set your modified value here
    });
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
      child: Scaffold(
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(colorPrimary)),
                            onPressed: () {
                              pauseCards();
                            },
                            child: Text(isPaused ? 'Cards Paused' : 'Pause Cards', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                          ),

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
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(user.teamName, style: const TextStyle(color: Color(colorPrimary), fontSize: 16, fontWeight: FontWeight.w600)),
                              
                                !isPaused
                                ? Text('Started: ${results.start}', style: TextStyle(color: Colors.grey.shade700, fontSize: 14))
                                : Text( 
                                  "On Pause!"
                                , style: TextStyle(color: Colors.grey.shade700, fontSize: 14)
                                ),
                              Text(results.points.toString(), style: TextStyle(color: Color(colorPrimary), fontSize: 14, fontWeight: FontWeight.w500))
                            ]
                          ),
                        ),
                      )
                    ],
                  ),

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
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 300,
                    child: selectedItem == SelectedItem.places
                    ? DisplayPlacesAndRoutesWidget(
                      selectedPlace: selectedPlace,
                      isPlaceSelected: isPlaceSelected,
                      onPlaceSelected: handlePlaceSelected,
                      onBackButtonPressed: handleBackButtonPressed,
                      user: user,
                    )
                    : DisplayActivitiesWidget(
                      selectedCategory: selectedCategory,
                      isCategorySelected: isCategorySelected,
                      onCategorySelected: handleCategorySelected,
                      onBackButtonPressed: handleBackButtonPressed,
                      user: user,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayActivitiesWidget extends StatelessWidget {
  final Category? selectedCategory;
  final bool isCategorySelected;
  final Function(Category) onCategorySelected;
  final VoidCallback onBackButtonPressed;
  final User user;

  const DisplayActivitiesWidget({
    super.key,
    required this.selectedCategory,
    required this.isCategorySelected,
    required this.onCategorySelected,
    required this.onBackButtonPressed,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedCategory == null) {
      return FutureBuilder<Activities>(
        future: HomeModel.getActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.categoryList.length,
              itemBuilder: (context, index) {
                Category category = snapshot.data!.categoryList[index];
                return GestureDetector(
                  onTap: () => onCategorySelected(category),
                  child: Card(
                    color: Color(colorPrimary),
                    child: Column(
                      children: <Widget>[
                        SizedBox(width: 4, height: 4,),
                        ListTile(
                          leading: Icon(
                            Icons.done,
                            color: Colors.white),
                          title: Text(
                            category.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),),
                        ),
                        SizedBox(width: 4, height: 4,),
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
      // ToDo: Style Cards as necessary.
      return ListView.builder(
        itemCount: selectedCategory!.activityList.length,
        itemBuilder: (context, index) {
          Activity activity = selectedCategory!.activityList[index];
          return ActivitiesCard(
            title: activity.name,
            valueMap: activity.points,
            user: user,
            category: selectedCategory!.name,
          );
        },
      );
    }
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
                    color: Color(colorPrimary),
                    child: Column(
                      children: <Widget>[
                        SizedBox(width: 4, height: 4,),
                        ListTile(
                          leading: Icon(
                            Icons.done,
                            color: Colors.white),
                          title: Text(
                            place.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),),
                        ),
                        SizedBox(width: 4, height: 4,),
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
                      //CustomMenu.getCustomMenu(context, user, state),
                      CustomMenu(user: user),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}