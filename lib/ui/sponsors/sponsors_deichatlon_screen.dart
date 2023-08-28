import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/misc/custom_menu.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';
import 'package:kisgeri24/ui/home/date_time_picker_screen.dart';

class SponsorsDeichatlonScreen extends StatefulWidget {
  final User user;

  const SponsorsDeichatlonScreen({Key? key, required this.user})
      : super(key: key);

  @override
  State createState() => _SponsorsDeichatlonScreenState();
}

enum SelectedClimber { climberOne, climberTwo }

enum SelectedItem { places, activities }

class _SponsorsDeichatlonScreenState extends State<SponsorsDeichatlonScreen> {
  late User user;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String passwordToDelete = '';
  String emailToDelete = '';

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
          } else if (state.authState == AuthState.didNotSetTime) {
            pushAndRemoveUntil(
                context, DateTimePickerScreen(user: user), false);
          } //add check for dateOutOfRange or create new screen for that. Add it to launcher.
        },
        child: Scaffold(
          key: scaffoldKey,
          body: ListView(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SponsorsDeichatlonScreenTitleWidget(user: user),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 25.0, right: 25.0, bottom: 10),
                      child: Divider(
                        color: Color.fromRGBO(255, 186, 0, 1),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Expanded(
                            child: Text(
                              'Sponsor page for Deichatlon, the best sports shop in the world.',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class SponsorsDeichatlonScreenTitleWidget extends StatelessWidget {
  final User user;

  const SponsorsDeichatlonScreenTitleWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 48.0, right: 24.0, left: 24.0),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.asset(
                          'assets/images/welcome_image.png',
                          alignment: Alignment.center,
                          width: 75.0,
                          height: 75.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "Let us introduce our awesome sponsor:",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 186, 0, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ])),
                CustomMenu(
                  user: user,
                  contextFrom: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
