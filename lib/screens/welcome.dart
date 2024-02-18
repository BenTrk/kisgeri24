import "package:flutter/material.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/ui/figma_design.dart";
import "package:responsive_sizer/responsive_sizer.dart";

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const MaterialApp(
          title: "Welcome screen",
          home: MyHomePage(title: "Készen álltok egy újabb kihívásra?"),
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
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                "Készen álltok\n egy újabb kihívásra?",
                style: Figma.typo.header2
                    .copyWith(color: Figma.colors.secondaryColor),
                textAlign: TextAlign.center,
              ),
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
            Text(
              "Kövessétek nyomon\ncsapatotok teljesítményét!",
              style:
                  Figma.typo.body.copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
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
              "Belépés",
            ),
          ),
        ),
      ),
    );
  }
}
