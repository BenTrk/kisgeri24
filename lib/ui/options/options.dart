import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';

class OptionsScreen extends StatefulWidget {
  final User user;

  const OptionsScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _OptionsState();
}

class _OptionsState extends State<OptionsScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        } //add check for dateOutOfRange or create new screen for that. Add it to launcher.
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(colorPrimary),
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: isDarkMode(context)
                          ? Colors.grey.shade50
                          : Colors.grey.shade900),
                ),
                leading: Transform.rotate(
                  angle: pi / 1,
                  child: Icon(
                    Icons.exit_to_app,
                    color: isDarkMode(context)
                        ? Colors.grey.shade50
                        : Colors.grey.shade900,
                  ),
                ),
                onTap: () {
                  context.read<AuthenticationBloc>().add(LogoutEvent());
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Options',
            style: TextStyle(
                color: isDarkMode(context)
                    ? Colors.grey.shade50
                    : Colors.grey.shade900),
          ),
          iconTheme: IconThemeData(
              color: isDarkMode(context)
                  ? Colors.grey.shade50
                  : Colors.grey.shade900),
          backgroundColor:
              const Color(colorPrimary),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.getTeamName()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.email),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.userID),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
