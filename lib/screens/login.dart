import "package:flutter/material.dart";
import 'package:gap/gap.dart';
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/ui/figma_design.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class LoginFigma extends StatefulWidget {
  const LoginFigma({super.key});

  @override
  State<LoginFigma> createState() => _LoginFigmaState();
}

class _LoginFigmaState extends State<LoginFigma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Figma.colors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Gap(10.h),
            Text(
              "Belépés",
              style: Figma.typo.header2
                  .copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
            ),
            Gap(8.h),
            Text(
              "Az első bejelentkezéshez használd a sikeres nevezés\nután kapott ideiglenes jelszavadat.",
              style: Figma.typo.smallerText
                  .copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
            ),
            Gap(8.h),
            SizedBox(
              width: 79.w,
              height: 55,
              child: TextField(
                style: Figma.typo.smallerText
                    .copyWith(color: Figma.colors.errorColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Figma.colors.secondaryColor,
                  floatingLabelBehavior: FloatingLabelBehavior.never, // TODO maybe use hints?
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "E-MAIL CÍM",
                ),
              ),
            ),
            Gap(5.h),
            SizedBox(
              width: 79.w,
              height: 55,
              child: TextField(
                style: Figma.typo.smallerText
                    .copyWith(color: Figma.colors.errorColor),
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Figma.colors.secondaryColor,
                  floatingLabelStyle: Figma.typo.smallerText,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "JELSZÓ",
                ),
              ),
            ),
            TextButton(
              onPressed: //TODO implement this
                  () {
                logger.i("Forgot password button is pressed.");
              },
              child: Text(
                "Elfelejtettem a jelszavam",
                style: Figma.typo.smallerText
                    .copyWith(color: Figma.colors.primaryColor),
              ),
              // style: Figma.buttons.textButtonStyle, TODO: #129
            ),
            Gap(10.h),
            SizedBox(
              width: 56.w,
              child: OutlinedButton(
                style: Figma.buttons.primaryButtonStyle,
                onPressed: () async {
                  // Navigate to login.dart
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginFigma(),
                    ),
                  );
                  logger.i("Enter button is pressed.");
                },
                child: const Text(
                  "BELÉPÉS",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
