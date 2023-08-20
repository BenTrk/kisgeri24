import 'dart:developer';

import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/ui/options/options_screen.dart';
import 'package:kisgeri24/ui/sponsors/sponsors_bedrull_screen.dart';

import '../constants.dart';
import '../model/authentication_bloc.dart';
import '../model/user.dart';
import '../services/helper.dart';
import '../ui/climbs & more/climbs_and_more_screen.dart';
import '../ui/home/home_screen.dart';
import '../ui/sponsors/sponsors_deichatlon_screen.dart';
import '../ui/sponsors/sponsors_randomsponsor_screen.dart';

class CustomMenu extends StatefulWidget {
  final User user;
  final BuildContext contextFrom;
  const CustomMenu({super.key, required this.user, required this.contextFrom});

  @override
  State createState() => _CustomMenuState();
}

  class _CustomMenuState extends State<CustomMenu>{
    late User user;
    late bool isStartTimeSet;

    @override
    void initState() {
      user = widget.user;
      isStartTimeSet = user.isStartDateSet;
      super.initState();
    }

    @override
    Widget build(BuildContext context){
      return Positioned(
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
                      showSnackBar(context, 'You did not set the start time yet.');
                    } else {
                      pushReplacement( context, HomeScreen(user: user));
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
                      pushReplacement( context, ClimbsAndMoreScreen(user: user));
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
                    pushReplacement(
                          context, OptionsScreen(user: user));
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
                    pushReplacement(
                          context, SponsorsBedRullScreen(user: user));
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
                    pushReplacement(
                          context, SponsorsDeichatlonScreen(user: user));
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
                    pushReplacement(
                          context, SponsorsRandomSponsorScreen(user: user));
                  },
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.exit_to_app),
                  color: Colors.white,
                  onPressed: () {
                    log('Logout');
                    context.read<AuthenticationBloc>().add(LogoutEvent());
                  },
                ),
              ),
            ],
          )
      );
    }
}