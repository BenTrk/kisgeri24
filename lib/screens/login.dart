import "package:flutter/material.dart";
import "package:flutter/services.dart";
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 1.0),
                    child: Text("E-MAIL CÍM",
                        style: Figma.typo.smallerText
                            .copyWith(color: Figma.colors.primaryColor)),
                  ),
                  TextField(
                    style: Figma.typo.smallerText
                        .copyWith(color: Figma.colors.textFieldHintColor),
                    decoration: Figma.textfieldstyle.textFieldStyle
                        .copyWith(hintText: "email@address.com"),
                  ),
                ],
              ),
            ),
            Gap(5.h),
            SizedBox(
              width: 79.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 1.0),
                    child: Text("JELSZÓ",
                        style: Figma.typo.smallerText.copyWith(
                          color: Figma.colors.primaryColor,
                        )),
                  ),
                  TextField(
                    style: Figma.typo.smallerText
                        .copyWith(color: Figma.colors.textFieldHintColor),
                    obscureText: true,
                    decoration: Figma.textfieldstyle.textFieldStyle.copyWith(hintText: "••••••"),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              widthFactor: 2.25,
              child: TextButton(
                onPressed: //TODO implement this
                    () {
                  logger.i("Forgot password button is pressed.");
                },
                style: Figma.buttons.textButtonStyle, // TODO: #129
                child: Text(
                  "Elfelejtetted a jelszavadat?",
                  style: Figma.typo.smallerText
                      .copyWith(color: Figma.colors.primaryColor),
                ),
              ),
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
                  "BELÉPEK",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
