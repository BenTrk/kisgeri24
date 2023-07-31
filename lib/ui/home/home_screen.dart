import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/misc/customMenu.dart';
import 'package:kisgeri24/model/init.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';
import 'package:kisgeri24/ui/home/model/home_model.dart';
import '../../classes/places.dart';
import 'date_time_picker_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen(
    {Key? key, required this.user}
    ) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Place? selectedPlace;
  bool isPlaceSelected = false;

  void handleBackButtonPressed() {
    setState(() {
      selectedPlace = null;
      isPlaceSelected = false;
    });
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
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

                  isPlaceSelected
                    ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: handleBackButtonPressed,
                      )
                    : SizedBox(),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: DisplayPlacesAndRoutesWidget(selectedPlace: selectedPlace,
                      isPlaceSelected: isPlaceSelected,
                      onPlaceSelected: (Place place) {
                        setState(() {
                          selectedPlace = place;
                          isPlaceSelected = true;
                        });
                      },
                      onBackButtonPressed: () {
                        setState(() {
                          selectedPlace = null;
                          isPlaceSelected = false;
                        });}),
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

class DisplayPlacesAndRoutesWidget extends StatelessWidget {
  final Place? selectedPlace;
  final bool isPlaceSelected;
  final Function(Place) onPlaceSelected;
  final VoidCallback onBackButtonPressed;

  DisplayPlacesAndRoutesWidget({
    required this.selectedPlace,
    required this.isPlaceSelected,
    required this.onPlaceSelected,
    required this.onBackButtonPressed,
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
                    // Your Card UI for each Place here
                    child: Text(place.name),
                  ),
                );
              },
            );
          }
        },
      );
    } else {
      // Display the list of routes for the selected Place here
      // You can access the selectedPlace and its routeList to build the UI
      return ListView.builder(
        itemCount: selectedPlace!.routeList.length,
        itemBuilder: (context, index) {
          RockRoute route = selectedPlace!.routeList[index];
          return Card(
            // Your Card UI for each Route here
            child: Text(route.name),
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