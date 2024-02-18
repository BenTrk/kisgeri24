import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Figma {
  // Colors
  static const Colors colors = Colors();

  // Typography
  static Typography typo = Typography();

  // Buttons
  static Buttons buttons = Buttons();

  // Icons
  static Icons icons = Icons();
}

class Colors {
  const Colors();

  final Color backgroundColor = const Color(0xff181305);
  final Color primaryColor = const Color(0xffFFBA00);
  final Color secondaryColor = const Color(0xffF9F2E0);
  final Color errorColor = const Color(0x7fFF0000);

  final Color disabledColor = const Color(0xffD9D9D9);
  final Color primaryButtonHoverColor = const Color(0xffFFDA76);
  final Color secondaryButtonHoverColor = const Color(0xff5F490E);
  final Color navbarSelectedBackgroundColor = const Color(0x99745501);

  final Color transparentColor = const Color(0x00000000);
}

class Typography {
  Typography();

  final TextStyle header1 = const TextStyle(
    fontFamily: "Oswald",
    fontWeight: FontWeight.bold,
    fontSize: 40,
    letterSpacing: -0.2,
  );

  final TextStyle header2 = const TextStyle(
    fontFamily: "Oswald",
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: -0.2,
  );

  final TextStyle body = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.4,
  );

  final TextStyle bold = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 16,
    height: 1.4,
  );

  final TextStyle smallerText = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  final TextStyle preTitle = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 10,
    letterSpacing: 0.3,
  );

  final TextStyle button = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 10,
    letterSpacing: 0.3,
  );
}

class Buttons {
  Buttons();

  final ButtonStyle primaryButtonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(Figma.typo.button),
    fixedSize: MaterialStateProperty.all(const Size(double.infinity, 35)),
    // To size the button, wrap it with a SizedBox with a width
    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
      // Typically the color of the text on the button
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.backgroundColor;
      },
    ),
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      // The color of the button itself
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Figma.colors.disabledColor;
        }
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.primaryColor;
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      // A subtle color change to provide visual feedback
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return Figma.colors.primaryButtonHoverColor;
        }
        if (states.contains(MaterialState.hovered)) {
          return Figma.colors.primaryButtonHoverColor;
        }
        if (states.contains(MaterialState.pressed)) { // TODO "Pressed" is different in figma but this is good enough for now, phone does not have "hover" anyway
          return Figma.colors.primaryButtonHoverColor;
        }
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.transparentColor;
      },
    ),
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  final ButtonStyle secondaryButtonStyle = ButtonStyle(
    // Use OutlinedButton widget for secondaryButton
    textStyle: MaterialStateProperty.all(Figma.typo.button),
    fixedSize: MaterialStateProperty.all(const Size(double.infinity, 35)),
    // To size the button, wrap it in a SizedBox with a width and height
    side: MaterialStateBorderSide.resolveWith(
      // The color of the OutlinedButton's border
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(color: Figma.colors.disabledColor);
        }
        if (states.contains(MaterialState.error)) {
          return BorderSide(color: Figma.colors.errorColor);
        }
        return BorderSide(
            color: Figma.colors.primaryColor); // Default to primary color
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
      // Typically the color of the text on the button
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Figma.colors.disabledColor;
        }
        if (states.contains(MaterialState.pressed)) {
          return Figma.colors.backgroundColor;
        }
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.primaryColor; // Default to primary color
      },
    ),
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      // The color of the button itself
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.transparentColor; // Default to transparent
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      // A subtle color change to provide visual feedback
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return Figma.colors.secondaryButtonHoverColor;
        }
        if (states.contains(MaterialState.hovered)) {
          return Figma.colors.secondaryButtonHoverColor;
        }
        if (states.contains(MaterialState.pressed)) {
          return Figma.colors.primaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.transparentColor;
      },
    ),
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

class Icons {
  Icons();

  final IconData arrowLeft = FeatherIcons.arrowLeft;
  final IconData bell = FeatherIcons.bell;
  final IconData calendar = FeatherIcons.calendar;
  final IconData checkCircle = FeatherIcons.checkCircle;
  final IconData checkSquare = FeatherIcons.checkSquare;
  final IconData chevronDown = FeatherIcons.chevronDown;
  final IconData edit = FeatherIcons.edit;
  final IconData filter = FeatherIcons.filter;
  final IconData home = FeatherIcons.home;
  final IconData image = FeatherIcons.image;
  final IconData menu = FeatherIcons.menu;
  final IconData moreHorizontal = FeatherIcons.moreHorizontal;
  final IconData pieChart = FeatherIcons.pieChart;
  final IconData plusCircle = FeatherIcons.plusCircle;
  final IconData plusSquare = FeatherIcons.plusSquare;
  final IconData repeat = FeatherIcons.repeat;
  final IconData search = FeatherIcons.search;
  final IconData settings = FeatherIcons.settings;
  final IconData user = FeatherIcons.user;
}
