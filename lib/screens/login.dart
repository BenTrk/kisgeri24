import "package:flutter/material.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/ui/figma_design.dart";
import "package:responsive_sizer/responsive_sizer.dart";

Future<void> main() async {
  runApp(const LoginFigma());
}

class LoginFigma extends StatelessWidget {
  const LoginFigma({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const MaterialApp(
          title: "Login screen",
          home: MyHomePage(title: "Belépés"),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              // previously (top: 80),
              padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
              child: Text(
                "Belépés",
                style: Figma.typo.header2
                    .copyWith(color: Figma.colors.secondaryColor),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Az első bejelentkezéshez használd a sikeres nevezés\nután kapott ideiglenes jelszavadat.",
              style: Figma.typo.smallerText
                  .copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
            ),
            SizedBox(
              width: 65.w,
              height: 10.w,
              child: TextField(
                style: Figma.typo.smallerText
                    .copyWith(color: Figma.colors.errorColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Figma.colors.secondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "E-MAIL CÍM",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
            ),
            SizedBox(
              width: 65.w,
              height: 10.w,
              child: TextField(
                style: Figma.typo.smallerText
                    .copyWith(color: Figma.colors.errorColor),
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Figma.colors.secondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "JELSZÓ",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10.5.h),
        child: SizedBox(
          width: 56.w,
          child: OutlinedButton(
            style: Figma.buttons.primaryButtonStyle,
            onPressed: () {
              logger.i("Enter button is pressed.");
            },
            child: const Text(
              "BELÉPÉS",
            ),
          ),
        ),
      ),
    );
  }
}
