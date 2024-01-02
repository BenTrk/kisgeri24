import "dart:async";

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/firebase_options.dart';
import 'package:kisgeri24/logging.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/screens/overview/overview_screen.dart';
import 'package:kisgeri24/services/firebase_service.dart';
import 'package:kisgeri24/ui/figma_design.dart' as kisgeri_design;
import 'package:kisgeri24/ui/loading_cubit.dart';
import 'package:flutter/foundation.dart';

void main() async {
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: facebookAppID,
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => AuthenticationBloc(), lazy: true),
      RepositoryProvider(create: (_) => LoadingCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      if (kIsWeb) {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
      } else {
        await Firebase.initializeApp();
      }
      setState(() {
        setUpEmulatorIfNeeded();
        FirebaseSingletonProvider.instance;
        logger.i(
          "Firebase init succeeded, instance: ${FirebaseSingletonProvider.instance}",
        );
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return const MaterialApp(
        home: Scaffold(
          body: ColoredBox(
            color: Colors.white,
            child: Center(
                child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 25,
                ),
                SizedBox(height: 16),
                Text(
                  "Failed to initialise firebase!",
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
              ],
            )),
          ),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return const ColoredBox(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    unawaited(
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
    );

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kisgeri_design.Figma.colors.backgroundColor,
        appBarTheme:
            const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle:
                TextStyle(color: kisgeri_design.Figma.colors.secondaryColor)),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: kisgeri_design.Figma.colors.primaryColor,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: const bool.fromEnvironment("DEBUG_MODE"),
      color: const Color(colorPrimary),
      home: const OverviewScreen(key: Key("overview_screen")),
    );
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  void setUpEmulatorIfNeeded() {
    setUpDbEmulatorIfPossible();
    setUpAuthEmulatorIfPossible();
    setUpFirestoreEmulatorIfPossible();
  }

  void setUpDbEmulatorIfPossible() {
    String localDbHost = const String.fromEnvironment("FIREBASE_DB_HOST");
    int localDbPort = const int.fromEnvironment("FIREBASE_DB_PORT");
    if (localDbHost.isNotEmpty && localDbPort != 0) {
      logger.d(
          "Local database is about to set up to: host: $localDbHost, port: $localDbPort");
      FirebaseSingletonProvider.instance.database
          .useDatabaseEmulator(localDbHost, localDbPort);
    }
  }

  void setUpAuthEmulatorIfPossible() {
    String localAuthHost = const String.fromEnvironment("FIREBASE_AUTH_HOST");
    int localAuthPort = const int.fromEnvironment("FIREBASE_AUTH_PORT");
    if (localAuthHost.isNotEmpty && localAuthPort != 0) {
      logger.d(
          "Local auth is about to set up to: host: $localAuthHost, port: $localAuthPort");
      FirebaseSingletonProvider.instance.authInstance
          .useAuthEmulator(localAuthHost, localAuthPort);
    }
  }

  void setUpFirestoreEmulatorIfPossible() {
    String localFsHost = const String.fromEnvironment("FIREBASE_FSTORE_HOST");
    int localFsPort = const int.fromEnvironment("FIREBASE_FSTORE_PORT");
    if (localFsHost.isNotEmpty && localFsPort != 0) {
      logger.d(
          "Local firestore is about to set up to: host: $localFsHost, port: $localFsPort");
      FirebaseSingletonProvider.instance.firestoreInstance
          .useFirestoreEmulator(localFsHost, localFsPort);
    }
  }
}
