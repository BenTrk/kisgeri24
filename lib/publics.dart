import 'dart:async';

import 'package:kisgeri24/classes/acivities.dart';
import 'package:kisgeri24/classes/places.dart';
import 'package:kisgeri24/constants.dart';

import 'classes/results.dart';

//Set to default 12H ince it is the default selection on the sign up page.
String category = categories[1];
String dateTime = '';
String teamDate = '';
String teamStartTime = '7:15';

Places places = Places();
Activities activities = Activities();
Results results = Results(points:0, start:'');
Category climbersCategory = Category(name: 'Climbers');