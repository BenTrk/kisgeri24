import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';

import '../../misc/customMenu.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
                  HomeScreenTitleWidget(user: user,),
                  
                  const Padding(
                    padding: EdgeInsets.only(left:25.0, right: 25.0, bottom: 10),
                    child: Divider( color: Color.fromRGBO(255, 186, 0, 1),),
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
                      CustomMenu.getCustomMenu(context, user),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
