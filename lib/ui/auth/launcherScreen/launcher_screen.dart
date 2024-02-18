import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/constants.dart';
import "package:kisgeri24/screens/welcome.dart";
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';
import 'package:kisgeri24/ui/home/home_screen.dart';
import '../../home/date_time_picker_screen.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(CheckFirstRunEvent());
  }

  //Create the necessary screen as follows:
  // In case user is authenticated: Home Screen
  // In case user is unauthenticated: Welcome Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(colorPrimary),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.authState) {
            case AuthState.authenticated:
              pushReplacement(context, HomeScreen(user: state.user!));
              break;
            case AuthState.unauthenticated:
              pushReplacement(context, const WelcomeFigma());
              break;
            case AuthState.didNotSetTime:
              pushReplacement(context, DateTimePickerScreen(user: state.user!));
              break;
            case AuthState.outOfDateTimeRange:
              //Maybe a copy with no database saves and a mock screen?
              pushReplacement(context, HomeScreen(user: state.user!));
              break;
            case AuthState.didNotPayYet:
              pushReplacement(context, const WelcomeScreen());
              break;
          }
        },
        child: const Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Color(colorPrimary)),
          ),
        ),
      ),
    );
  }
}
