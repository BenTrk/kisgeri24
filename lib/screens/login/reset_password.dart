import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/screens/login/login.dart";
import "package:kisgeri24/ui/figma_design.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class ResetPasswordFigma extends StatefulWidget {
  const ResetPasswordFigma({super.key});

  @override
  State<ResetPasswordFigma> createState() => _ResetPasswordFigmaState();
}

class _ResetPasswordFigmaState extends State<ResetPasswordFigma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Figma.colors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.h),
        child: AppBar(
          backgroundColor: Figma.colors.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Figma.icons.arrowLeft,
              color: Figma.colors.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
              logger.i("Back button is pressed.");
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add meg az új jelszavad",
              style: Figma.typo.header2
                  .copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
            ),
            Gap(8.h),
            Text(
              "A bejelentkezéshez kérlek változtasd meg az\nautomatikusan kapott jelszavadat.",
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
                    child: Text("JELSZÓ",
                        style: Figma.typo.smallerText.copyWith(
                          color: Figma.colors.primaryColor,
                        )),
                  ),
                  TextField(
                    style: Figma.typo.smallerText
                        .copyWith(color: Figma.colors.textFieldHintColor),
                    obscureText: true,
                    decoration: Figma.textfieldstyle.textFieldStyle
                        .copyWith(hintText: "••••••"),
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
                    child: Text("JELSZÓ MEGERŐSÍTÉSE",      // TODO check if they match
                        style: Figma.typo.smallerText.copyWith(
                          color: Figma.colors.primaryColor,
                        )),
                  ),
                  TextField(
                    style: Figma.typo.smallerText
                        .copyWith(color: Figma.colors.textFieldHintColor),
                    obscureText: true,
                    decoration: Figma.textfieldstyle.textFieldStyle
                        .copyWith(hintText: "••••••"),
                  ),
                ],
              ),
            ),
            Gap(10.h),
            SizedBox(
              width: 56.w,
              child: OutlinedButton(
                style: Figma.buttons.primaryButtonStyle,
                onPressed: () async {
                  // TODO: Implement setting the password for the first time, temporary navigate to login.dart
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginFigma(),
                    ),
                  );
                  logger.i("Set first password button is pressed.");
                },
                child: const Text(
                  "MEGÚJÍTOM",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
