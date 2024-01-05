import 'package:flutter/material.dart';

class Figma {
  // Colors
  static const Colors colors = Colors();

  // Typography
  static Typography typo = Typography();

  // Buttons
  static Buttons buttons = Buttons();
}

class Colors {
  const Colors();

  final primaryColor = const Color(0xff181305);
  final secondaryColor = const Color(0xffFFBA00);
  final hoverColor = const Color(0xffFFDA76);
  final accentColor = const Color(0xffF9F2E0);
  final disabledColor = const Color(0xffD9D9D9);
  final errorColor = const Color(0x7FFF0000); // 50% opacity red
  final transparentColor = const Color(0x00000000);
}

class Typography {
  Typography();

  final header1 = const TextStyle(
    fontFamily: "Oswald",
    fontWeight: FontWeight.bold,
    fontSize: 40,
    letterSpacing: -0.2,
  );

  final header2 = const TextStyle(
    fontFamily: "Oswald",
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: -0.2,
  );

  final body = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.4,
  );

  final bold = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 16,
    height: 1.4,
  );

  final smallerText = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  final preTitle = const TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 10,
    letterSpacing: 0.3,
  );

  final button = const TextStyle(
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
    fixedSize: MaterialStateProperty.all(const Size(203, 35)),
    // TODO fixedSize is from the Figma design, but should be calculated
    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
      // Typically the color of the text on the button
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Figma.colors.primaryColor;
        }
        if (states.contains(MaterialState.selected)) {
          return Figma.colors.primaryColor;
        }
        if (states.contains(MaterialState.pressed)) {
          return Figma.colors.primaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.primaryColor;
      },
    ),
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      // The color of the button itself
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Figma.colors.disabledColor;
        }
        if (states.contains(MaterialState.selected)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.pressed)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.secondaryColor;
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      // A subtle color change to provide visual feedback
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.hovered)) {
          return Figma.colors.hoverColor;
        }
        if (states.contains(MaterialState.pressed)) {
          return Figma.colors.secondaryColor;
        }
        return null;
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
    textStyle: MaterialStateProperty.all(Figma.typo.button),
    fixedSize: MaterialStateProperty.all(const Size(203, 35)),
    // TODO fixedSize is from Figma design, but should be calculated
    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
      // Typically the color of the text on the button
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Figma.colors.disabledColor;
        }
        if (states.contains(MaterialState.selected)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.pressed)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return Figma.colors.secondaryColor; //Default to secondary color
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
        return Figma.colors.transparentColor; //Default to transparent
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      // A subtle color change to provide visual feedback
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.hovered)) {
          return Figma.colors.secondaryColor.withOpacity(0.37);
        }
        if (states.contains(MaterialState.pressed)) {
          return Figma.colors.secondaryColor;
        }
        return null;
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
