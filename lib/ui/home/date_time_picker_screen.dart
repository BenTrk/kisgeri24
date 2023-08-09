
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/misc/customMenu.dart';
import 'package:kisgeri24/publics.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../constants.dart';
import '../../model/authentication_bloc.dart';
import '../../model/user.dart';
import '../../services/helper.dart';
import '../auth/welcome/welcome_screen.dart';
import '../home/model/date_time_picker_model.dart';
import '/misc/toggleButtonsDateSelector.dart';
import 'home_screen.dart';


class DateTimePickerScreen extends StatefulWidget {
  final User user;
  const DateTimePickerScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePickerScreen> {
  late User user;
  //ValueNotifier<String> dateTime = ValueNotifier<String>(defaultDateTime.toString());
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var teamHours = 07;
  var teamMinutes = 15;

  @override
  void initState() {
    super.initState();
    user = widget.user;

    teamHours = 07;
    teamMinutes = 15;
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
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
                  //Menu inside :)
                  LogoImageWidget(user: user),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Looks like your team did not pick a start date yet. Let\'s solve this problem!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(colorPrimary),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Divider( color: Color(colorPrimary),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomToggleDateButtons(),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Hours:',
                                style: TextStyle(color: Color(colorPrimary), fontSize: 16)
                                ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child:
                                NumberPicker(
                                  textStyle: const TextStyle(color: Color(colorPrimary)),
                                  value: teamHours,
                                  axis: Axis.vertical,
                                  minValue: 0,
                                  maxValue: 24,
                                  itemHeight: 40,
                                  onChanged: (value) => setState(() => teamHours = value),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: const Color.fromRGBO(255, 186, 0, 1), width: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Minutes:',
                                style: TextStyle(color: Color(colorPrimary), fontSize: 16)
                                ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child:
                                NumberPicker(
                                  textStyle: const TextStyle(color: Color(colorPrimary)),
                                  value: teamMinutes,
                                  axis: Axis.vertical,
                                  minValue: 0,
                                  maxValue: 45,
                                  itemHeight: 40,
                                  step: 15,
                                  onChanged: (value) => setState(() => teamMinutes = value),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: const Color.fromRGBO(255, 186, 0, 1), width: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(colorPrimary),
                                    minimumSize: const Size(150, 40)
                                  ),
                              onPressed: 
                                _showAlertDialog,
                              child: const Text(
                                'All Set!',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        dateTime = DateTimePickerModel().setDateTime(teamHours, teamMinutes, teamDate);

        return AlertDialog( 
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Is $dateTime really your start time?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                //Move to the HomePage! Disable database writes while not in competition
                user.isStartDateSet = true;
                Navigator.of(dialogContext).pop();
                DateTimePickerModel().writeDateToDatabase(context, dateTime, user);
                pushAndRemoveUntil(
                      context, HomeScreen(user: user), false);
              },
            ),
          ],
        );
      },
    );
  }

}

class LogoImageWidget extends StatelessWidget {
  final User user;

  const LogoImageWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [ 
          Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0, right: 24.0, left: 24.0),
                        child: Image.asset(
                          'assets/images/welcome_image.png',
                        alignment: Alignment.center,
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                        ),
                      ), 
                      CustomMenu(user: user, contextFrom: context,),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

