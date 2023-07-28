import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/services/helper.dart';
import 'package:flutter_login_screen/model/authentication_bloc.dart';
import 'package:flutter_login_screen/services/data.dart';
import 'package:flutter_login_screen/ui/auth/onBoarding/on_boarding_screen.dart';
import 'package:flutter_login_screen/ui/auth/welcome/welcome_screen.dart';
import 'package:flutter_login_screen/ui/home/home_screen.dart';

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
  // In case first run of application: OnBoarding Screen
  // In case user is authenticated: Home Screen
  // In case user is unauthenticated: Welcome Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(colorPrimary),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.authState) {
            case AuthState.firstRun:
              pushReplacement(
                  context,
                  OnBoardingScreen(
                    images: imageList,
                    titles: titlesList,
                    subtitles: subtitlesList,
                  ));
              break;
            case AuthState.authenticated:
              if (state.user!.startDate == defaultDateTime.toString()){
                pushReplacement(context, DateTimePickerScreen(user : state.user!));
                break;
                //TODO: else if startTime isBefore(compStartTime) || startTime isAfter(compEndTime)
                //For that: get compStartTime and compEndTime from realtime DB (/BasicData/)
              } else {
                pushReplacement(context, HomeScreen(user: state.user!));
                break;
              }
            case AuthState.unauthenticated:
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
