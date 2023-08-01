import 'dart:developer';

import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/ui/options/options.dart';
import 'package:kisgeri24/ui/sponsors/sponsors.dart';

import '../constants.dart';
import '../model/authentication_bloc.dart';
import '../model/user.dart';
import '../services/helper.dart';
import '../ui/auth/welcome/welcome_screen.dart';
import '../ui/climbs & more/climbs_and_more.dart';
import '../ui/home/home_screen.dart';

class CustomMenu extends StatefulWidget {
  final User user;
  const CustomMenu({super.key, required this.user});

  @override
  State createState() => _CustomMenuState();
}

  class _CustomMenuState extends State<CustomMenu>{
    late User user;
    late bool isStartTimeSet;

    @override
    void initState() {
      user = widget.user;
      isStartTimeSet = false;
      super.initState();
    }

    @override
    Widget build(BuildContext context){
      return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.authState != AuthState.didNotSetTime) {
            isStartTimeSet = true;
          } else if (state.authState == AuthState.unauthenticated){
            pushAndRemoveUntil(context, const WelcomeScreen(), false);
          }
        },
          child: Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: ExpandableMenu(
            backgroundColor: const Color(colorPrimary),
            width: 40.0,
            height: 40.0,
            items: [
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {
                    log('Pressed Home');
                    if (!isStartTimeSet) {
                      log('Boyaa');
                      showSnackBar(context, 'You did not set the start time yet.');
                    } else {
                      pushAndRemoveUntil( context, HomeScreen(user: user), false);
                    }
                  },
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.query_stats),
                  color: Colors.white,
                  onPressed: () {
                    log('Pressed Stats');
                    if (!isStartTimeSet) {
                      log('Boyaa');
                      showSnackBar(context, 'You did not set the start time yet.');
                    } else {
                      pushAndRemoveUntil( context, ClimbsAndMoreScreen(user: user), false);
                    }
                  },
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.manage_accounts),
                  color: Colors.white,
                  onPressed: () {
                    log('Pressed ManageAccounts');
                    pushAndRemoveUntil(
                          context, OptionsScreen(user: user), false);
                    },
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.paid),
                  color: Colors.white,
                  onPressed: () {
                    log('Pressed Sponsor');
                    pushAndRemoveUntil(
                          context, SponsorsScreen(user: user), false);
                    },
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.paid),
                  color: Colors.white,
                  onPressed: () {
                    log('Pressed Sponsor');
                    pushAndRemoveUntil(
                          context, SponsorsScreen(user: user), false);
                    },
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.paid),
                  color: Colors.white,
                  onPressed: () {
                    log('Pressed Sponsor');
                    pushAndRemoveUntil(
                          context, SponsorsScreen(user: user), false);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
}