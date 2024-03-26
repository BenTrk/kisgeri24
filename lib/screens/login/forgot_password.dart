import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/screens/login/login.dart";
import "package:kisgeri24/ui/figma_design.dart";
import "package:responsive_sizer/responsive_sizer.dart";


class ForgotPasswordFigma extends StatefulWidget {
  const ForgotPasswordFigma({super.key});

  @override
  State<ForgotPasswordFigma> createState() => _ForgotPasswordFigmaState();
}

class _ForgotPasswordFigmaState extends State<ForgotPasswordFigma> {
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
            Gap(10.h),
            Text(
              "Elfelejtetted a jelszavadat?",
              style: Figma.typo.header2
                  .copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
            ),
            Gap(8.h),
            Text(
              "Ne aggódj, bárkivel előfordul. A jelszó megújításához\nkérünk, írd be az e-mail címedet",
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
                        style: Figma.typo.smallerText.copyWith(
                          color: Figma.colors.primaryColor,
                        )),
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
            Gap(15.h),
            SizedBox(
              width: 56.w,
              child: OutlinedButton(
                style: Figma.buttons.primaryButtonStyle,
                onPressed: () async {
                  // TODO: Implement resetting the password through firebase, temporary navigate to login.dart
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginFigma(),
                    ),
                  );
                  logger.i("Firebase renew password button is pressed.");
                },
                child: const Text(
                  "Kérem a jelszómegújítást",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
