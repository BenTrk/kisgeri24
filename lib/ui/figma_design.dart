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

  final header2 = TextStyle(
    fontFamily: "Oswald",
    fontSize: 40,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.2,
    color: Figma.colors.primaryColor,
  );

  final header3 = TextStyle(
    fontFamily: "Oswald",
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: -0.2,
    color: Figma.colors.primaryColor,
  );

  final body = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.4,
    color: Figma.colors.primaryColor,
  );

  final bold = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 16,
    height: 1.4,
    color: Figma.colors.primaryColor,
  );

  final smallerText = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: Figma.colors.primaryColor,
  );

  final preTitle = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 10,
    letterSpacing: 0.3,
    color: Figma.colors.primaryColor,
  );

  final primaryButton = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 10,
    letterSpacing: 0.3,
    color: Figma.colors.primaryColor,
  );

  final secondaryButton = TextStyle(
    fontFamily: "Lato",
    fontWeight: FontWeight.bold,
    fontSize: 10,
    letterSpacing: 0.3,
    color: Figma.colors.secondaryColor,
    // TODO, Secondary button's colour will vary based on button state
  );
}

class Buttons {
  Buttons();

  final ButtonStyle primaryButtonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(Figma.typo.primaryButton),
    fixedSize: MaterialStateProperty.all(const Size(203, 35)),
    foregroundColor: MaterialStateProperty.all(Figma.colors.errorColor),
    // foregrColor will be figma.typo.button, so this is only red if something is wrong
    backgroundColor: MaterialStateProperty.all(Figma.colors.secondaryColor),
    // TODO move some MaterialState here
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.hovered)) {
          return const Color(0xffFFDA76);
        }
        if (states.contains(MaterialState.pressed)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.disabled)) {
          return Figma.colors.disabledColor;
        }
        if (states.contains(MaterialState.selected)) {
          return Figma.colors.secondaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Figma.colors.errorColor;
        }
        return null;
      },
    ),
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  );

  final ButtonStyle secondaryButtonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(Figma.typo.secondaryButton),
    fixedSize: MaterialStateProperty.all(const Size(203, 35)),
    foregroundColor: MaterialStateProperty.all(Figma.colors.errorColor),
    backgroundColor: MaterialStateProperty.all(Figma.colors.transparentColor),
    overlayColor: MaterialStateProperty.all(Figma.colors.transparentColor),
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  );
}
