import 'dart:developer';

import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:kisgeri24/ui/climbs%20&%20more/climbs_and_more.dart';
import 'package:kisgeri24/ui/options/options.dart';
import 'package:kisgeri24/ui/sponsors/sponsors.dart';

import '../constants.dart';
import '../model/user.dart';
import '../services/helper.dart';
import '../ui/home/home_screen.dart';

class CustomMenu{
  CustomMenu();

  static getCustomMenu(BuildContext context, User user){
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: ExpandableMenu(
        backgroundColor: Color(colorPrimary),
        width: 40.0,
        height: 40.0,
        items: [
          Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                log('Pressed Home');
                pushAndRemoveUntil(
                      context, HomeScreen(user: user), false);
                },
            ),
          ),
          Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.query_stats),
              color: Colors.white,
              onPressed: () {
                log('Pressed Stats');
                pushAndRemoveUntil(
                      context, ClimbsAndMoreScreen(user: user), false);
              },
            ),
          ),
          Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.manage_accounts),
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
              icon: Icon(Icons.paid),
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
              icon: Icon(Icons.paid),
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
              icon: Icon(Icons.paid),
              color: Colors.white,
              onPressed: () {
                log('Pressed Sponsor');
                pushAndRemoveUntil(
                      context, SponsorsScreen(user: user), false);
              },
            ),
          ),
        ],
      )
    );
  }
}