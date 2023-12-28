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
      title: 'Title_text',
      debugShowMaterialGrid: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xff181305)),
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
            const Text(
              'Készen álltok egy újabb kihívásra?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xffF9F2E0),
              ),
            ),
            const Image(
              image: AssetImage('assets/images/kisgeri_logo.png'),
              semanticLabel: "Kisgeri logo",
              isAntiAlias: true,
            ),
            const Text(
              'Nyomkodd a gombot és nő a szám :O ',
              style: TextStyle(
                color: Color(0xffF9F2E0),
              ),
            ),
            Text(
              '$_counter',
              style: const TextStyle(
                color: Color(0xffF9F2E0),
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xff181305),
          backgroundColor: const Color(0xffFFBA00),
          disabledForegroundColor: Colors.grey,
        ),
        onPressed: _incrementCounter,
        child: const Text(
          "Belépés",
          style: TextStyle(
            color: Color(0xffF9F2E0),
          ),
        ),
      ),
    );
  }
}
