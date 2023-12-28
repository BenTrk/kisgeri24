import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome screen',
      theme: ThemeData(
        // This needs to be moved to a separate file
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(0xffFFBA00, <int, Color>{
            50: Color(0xffFFBA00),
            100: Color(0xffFFBA00),
            200: Color(0xffFFBA00),
            300: Color(0xffFFBA00),
            400: Color(0xffFFBA00),
            500: Color(0xffFFBA00),
            600: Color(0xffFFBA00),
            700: Color(0xffFFBA00),
            800: Color(0xffFFBA00),
            900: Color(0xffFFBA00),
          }),
          backgroundColor: const Color(0xff181305),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            // Figma: Bold (strong)
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xffF9F2E0),
          ),
          bodyMedium: TextStyle(
            // Figma: Body
            fontFamily: "Lato",
            fontWeight: FontWeight.normal,
            fontSize: 16,
            height: 1.4,
            color: Color(0xffF9F2E0),
          ),
          bodySmall: TextStyle(
            // Figma: Smaller text
            fontFamily: "Lato",
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: Color(0xffF9F2E0),
          ),
          displayLarge: TextStyle(
            // Figma: Header 1
            fontFamily: "Oswald",
            fontSize: 40,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.2,
            color: Color(0xffF9F2E0),
          ),
          displayMedium: TextStyle(
            // Figma: Header 3
            fontFamily: "Oswald",
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: -0.2,
            color: Color(0xffF9F2E0),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Készen álltok egy újabb kihívásra?'),
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
  int _counter = 0;
  Color? _changingColor = Colors.orange[200];

  void _incrementCounter() {
    setState(() {
      _counter++;
      if ((_counter % 2) == 0) {
        _changingColor = Colors.blue[200];
      } else {
        _changingColor = Colors.orange[200];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Készen álltok egy újabb kihívásra?',
              style: Theme.of(context).textTheme.displayMedium,
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
              style: Theme.of(context).textTheme.bodyLarge,
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
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xff181305),
            backgroundColor: const Color(0xffFFBA00),
            disabledForegroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: _incrementCounter,
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
