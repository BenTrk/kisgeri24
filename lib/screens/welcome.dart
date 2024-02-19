import "package:flutter/material.dart";
import 'package:gap/gap.dart';
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/screens/login.dart";
import "package:kisgeri24/ui/figma_design.dart";
import "package:responsive_sizer/responsive_sizer.dart";

Future<void> main() async {
  runApp(const WelcomeFigma());
}

class WelcomeFigma extends StatelessWidget {
  const WelcomeFigma({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const MaterialApp(
          title: "Welcome screen",
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Figma.colors.backgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Gap(9.h), // previously (top: 80)
            Text(
              "Készen álltok\n egy újabb kihívásra?",
              style: Figma.typo.header2
                  .copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              // previously width: MediaQuery.sizeOf(context).width - 64
              width: 85.w,
              // previously width: MediaQuery.sizeOf(context).width - 64
              height: 85.w,
              child: const Image(
                image: AssetImage("assets/images/kisgeri_logo.png"),
                semanticLabel: "Kisgeri logo",
                isAntiAlias: true,
                fit: BoxFit.contain,
              ),
            ),
            Gap(10.h),
            Text(
              "Kövessétek nyomon\ncsapatotok teljesítményét!",
              style:
                  Figma.typo.body.copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
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
