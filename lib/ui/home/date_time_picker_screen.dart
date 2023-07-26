import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../model/authentication_bloc.dart';
import '../../model/user.dart';
import '../../publics.dart';
import '../../services/helper.dart';
import '../auth/welcome/welcome_screen.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';


class DateTimePickerScreen extends StatefulWidget {
  final User user;

  const DateTimePickerScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePickerScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  ValueNotifier<String> dateTime = ValueNotifier(defaultDateTime.toString());

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
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
            'Pick your start date!',
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Select your start date and time!'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.teamName),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: 
                ElevatedButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      dateFormat: 'dd MMMM yyyy HH:mm',
                      initialDateTime: DateTime.now(),
                      minDateTime: DateTime(2023, 05, 01, 00, 00),
                      maxDateTime: DateTime(2023, 05, 03, 00, 00),
                      onMonthChangeStartWithFirstDate: true,
                      onConfirm: (dateTimeSelected, List<int> index) {
                        DateTime selectdate = dateTimeSelected;
                        dateTime.value = DateFormat('dd-MMM-yyyy - HH:mm').format(selectdate);
                      },
                    );
                  },
                  child: const Text('Pick Date-Time'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: 
                ValueListenableBuilder<String>(
                  builder: (BuildContext context, String value, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //call write to database here
                        Text('Time selected: $value'),
                        child!,
                      ],
                    );
                  },
                valueListenable: dateTime,
                child: const Text('Yuhey'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}