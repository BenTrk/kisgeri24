import 'package:flutter/material.dart';

abstract class Figma {
  // Colors

  static const primaryColor = Color(0xff181305);
  static const secondaryColor = Color(0xffFFBA00);
  static const accentColor = Color(0xffF9F2E0);

  // Typography
  static const typoHeader2 = TextStyle(
    fontFamily: "Oswald",
    fontSize: 40,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.2,
    color: accentColor,
  );

  static const typoHeader3 = TextStyle(
    fontFamily: "Oswald",
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: -0.2,
    color: accentColor,
  );

  static const typoSubtitle = TextStyle(
    fontFamily: "Oswald",
    fontWeight: FontWeight.normal,
    fontSize: 24,
    letterSpacing: -0.2,
    color: accentColor,
  );

  static const typoBody = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.4,
    color: accentColor,
  );

  static const typoBold = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 16,
    height: 1.4,
    color: accentColor,
  );

  static const typoSmallerText = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: accentColor,
  );

  static const typoPreTitle = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 10,
    letterSpacing: 0.3,
    color: accentColor,
  );

  static const typoButton = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 10,
    letterSpacing: 0.3,
    color: accentColor,
  );
}
