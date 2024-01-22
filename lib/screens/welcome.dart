import 'package:flutter/material.dart';
import '/ui/figma_design.dart';
import 'package:kisgeri24/logging.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Welcome screen',
      home: MyHomePage(title: 'Készen álltok egy újabb kihívásra?'),
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
              padding: const EdgeInsets.only(top: 80),
              child: Text(
                'Készen álltok\n egy újabb kihívásra?',
                style: Figma.typo.header2
                    .copyWith(color: Figma.colors.secondaryColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 64,
              height: MediaQuery.sizeOf(context).width - 64,
              child: const Image(
                image: AssetImage('assets/images/kisgeri_logo.png'),
                semanticLabel: "Kisgeri logo",
                isAntiAlias: true,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Kövessétek nyomon\ncsapatotok teljesítményét!',
              style:
                  Figma.typo.body.copyWith(color: Figma.colors.secondaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width - 64,
          child: OutlinedButton(
            style: Figma.buttons.secondaryButtonStyle,
            onPressed: () {
              logger.i('Enter button is pressed.');
            },
            child: const Text(
              "Enter",
            ),
          ),
        ),
      ),
    );
  }
}
