import 'package:flutter/material.dart';
import '/ui/figma_design.dart';

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
      backgroundColor: Figma.colors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Készen álltok egy újabb kihívásra?',
              style: Figma.typo.header2.copyWith(color: Figma.colors.accentColor),
              textAlign: TextAlign.center,
            ),
            const Image(
              image: AssetImage('assets/images/kisgeri_logo.png'),
              semanticLabel: "Kisgeri logo",
              isAntiAlias: true,
              fit: BoxFit.contain,
              width: 400,
              height: 400,
            ),
            Text(
              'Kövessétek nyomon csapatotok teljesítményét!',
              style: Figma.typo.body.copyWith(color: Figma.colors.accentColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25), // TODO noob padding
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 200,
        height: 50,
        child: TextButton(
          style: Figma.buttons.primaryButtonStyle,
          onPressed: () {
            // TODO navigate to login screen
            Navigator.pushNamed(context, '/');
          },
          child: const Text(
            "Belépés",
            style: TextStyle(
              color: Color(0xff181305),
            ),
          ),
        ),
      ),
    );
  }
}
