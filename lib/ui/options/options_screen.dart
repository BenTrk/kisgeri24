
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/misc/customMenu.dart';
import 'package:kisgeri24/model/init.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/ui/auth/welcome/welcome_screen.dart';
import '../../constants.dart';
import '../../publics.dart';
import '../home/date_time_picker_screen.dart';
import 'options_model.dart';

class OptionsScreen extends StatefulWidget {
  final User user;

  const OptionsScreen(
    {Key? key, required this.user}
    ) : super(key: key);

  @override
  State createState() => _OptionsScreenState();
}

enum SelectedClimber { climberOne, climberTwo }
enum SelectedItem { places, activities }

class _OptionsScreenState extends State<OptionsScreen> {
  late User user;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late DatabaseReference resultsRef;
  StreamSubscription<DatabaseEvent>? _streamSubscription;
  
  bool isChangeEmail = false;
  bool isChangePassword = false;
  bool isDeleteUser = false;

  String passwordToDelete = '';
  String emailToDelete = '';

  @override
  void initState() {
    super.initState();
    user = widget.user;
    resultsRef = FirebaseDatabase.instance.ref('Results').child(user.userID);
    _streamSubscription = resultsRef.onValue.listen((event) {
      init.getResults(user, event.snapshot);
    });
  }

  enableTextField(String whichField) {
    setState(() {
      switch(whichField){
        case("changeEmail"): {
          isChangeEmail = true;
          isChangePassword = false;
          isDeleteUser = false;
          break;
        }
        case("changePassword"): {
          isChangePassword = true;
          isChangeEmail = false;
          isDeleteUser = false;
          break;
        }
        case("deleteUser"): {
          isDeleteUser = true;
          isChangeEmail = false;
          isChangePassword = false;
          break;
        }
        case ("none"): {
          isChangeEmail = false;
          isChangePassword = false;
          isDeleteUser = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        } else if (state.authState == AuthState.didNotSetTime) {
          pushAndRemoveUntil(context, DateTimePickerScreen(user: user), false);
        } //add check for dateOutOfRange or create new screen for that. Add it to launcher.
      },
      child: StreamBuilder(
        stream: resultsRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            //return CircularProgressIndicator(backgroundColor: Colors.transparent,);
          }

          return Scaffold(
            key: scaffoldKey,
            body: ListView(
              children: <Widget>[
                
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
        
                      OptionsScreenTitleWidget(user: user),
                      
                      const Padding(
                        padding: EdgeInsets.only(left:25.0, right: 25.0, bottom: 10),
                        child: Divider( color: Color.fromRGBO(255, 186, 0, 1),),
                      ),
        
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(user.teamName, style: const TextStyle(color: Color(colorPrimary), fontSize: 16, fontWeight: FontWeight.w600)),
                              Text('Started at: ${results.start}'),
                              Text('Category: ${user.category}'),
                            ]
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child:
                            Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => enableTextField("changeEmail"), 
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size.fromWidth(
                                              MediaQuery.of(context).size.width / 2),
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          backgroundColor: const Color(colorPrimary),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                            side: const BorderSide(
                                              color: Color(colorPrimary),
                                            ),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.email),
                                            Text('Change email'),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    enabled: isChangeEmail,
                                    style: const TextStyle(fontSize: 18.0),
                                    onSaved:(newValue) => changeEmail(newValue!),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: isChangeEmail ? const Color(colorPrimary) : Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Enter email',
                                      hintStyle: isChangeEmail ? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ) 
                            )
                      ),

                      const SizedBox(height: 10,),

                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: 
                            Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => enableTextField("changePassword"),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size.fromWidth(
                                              MediaQuery.of(context).size.width / 2),
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          backgroundColor: const Color(colorPrimary),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                            side: const BorderSide(
                                              color: Color(colorPrimary),
                                            ),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.password),
                                            Text('Reset password'),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    enabled: isChangePassword,
                                    style: const TextStyle(fontSize: 18.0),
                                    onSaved:(newValue) => changePassword(newValue!),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: isChangePassword ? const Color(colorPrimary) : Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Enter email',
                                      hintStyle: isChangePassword ? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              )
                          )
                      ),

                      const SizedBox(height: 10,),
                      
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: 
                            Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => enableTextField("deleteUser"),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size.fromWidth(
                                              MediaQuery.of(context).size.width / 2),
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          backgroundColor: const Color(colorPrimary),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                            side: const BorderSide(
                                              color: Color(colorPrimary),
                                            ),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.delete_forever),
                                            Text('Delete user'),
                                          ],
                                        )
                                      )
                                    ],
                                  ),

                                  const SizedBox(height: 5,),

                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    enabled: isDeleteUser,
                                    style: const TextStyle(fontSize: 18.0),
                                    onSaved:(newValue) => newValue == null ? emailToDelete = newValue! : null,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: isDeleteUser ? const Color(colorPrimary) : Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Enter email',
                                      hintStyle: isDeleteUser ? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.grey),
                                    ),
                                  ),

                                  const SizedBox(height: 5,),

                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    enabled: isDeleteUser,
                                    style: const TextStyle(fontSize: 18.0),
                                    onSaved:(newValue) => newValue == null ? passwordToDelete = newValue! : null,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: isDeleteUser ? const Color(colorPrimary) : Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Enter password',
                                      hintStyle: isDeleteUser ? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.grey),
                                    ),
                                  ),

                                  const SizedBox(height: 5,),

                                  ElevatedButton(
                                    onPressed: () => deleteUser(emailToDelete, passwordToDelete),
                                    style: ElevatedButton.styleFrom(
                                          fixedSize: Size.fromWidth(
                                              MediaQuery.of(context).size.width / 3.5),
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          backgroundColor: isDeleteUser
                                          ? const Color(colorPrimary)
                                          : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side: isDeleteUser
                                            ? 
                                              const BorderSide(
                                                color: Color(colorPrimary),
                                              )
                                            : 
                                              const BorderSide(
                                                color: Colors.grey,
                                              )
                                          ),
                                        ),
                                    child: const Text('Delete!')
                                  )

                                ],
                              )
                          ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          );
        }));
        }

          changeEmail(String email) {
            //Show a dialog!
            showChangeEmailDialog(context, email);
          }

          showChangeEmailDialog(BuildContext context, String email) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: Text('This action will change your email address to $email. Would you like to continue?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        enableTextField("none");
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        enableTextField("none");
                        OptionsModel.changeEmail(context, email);
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          }

          showChangePasswordDialog(BuildContext context, String email) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: Text('This action will reset your password. Would you like to continue?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        enableTextField("none");
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        enableTextField("none");
                        OptionsModel.changePassword(context, email);
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          }
          
          showDeleteUserDialog(BuildContext context, String emailToDelete, String passwordToDelete) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('This action will delete your user and remove you from the competition. Would you like to continue?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        enableTextField("none");
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        enableTextField("none");
                        OptionsModel.deleteUser(context, emailToDelete, passwordToDelete);
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          }

          changePassword(String email) {
            showChangePasswordDialog(context, email);
          }
          
          deleteUser(String emailToDelete, String passwordToDelete) {
            if (emailToDelete.isNotEmpty && passwordToDelete.isNotEmpty) {
              showDeleteUserDialog(context, emailToDelete, passwordToDelete);
            } else {
              showSnackBar(context, "Enter email and password!");
            }
          }
    }



class OptionsScreenTitleWidget extends StatelessWidget {
  final User user;

  const OptionsScreenTitleWidget({
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
                        child: 
                        Row(
                          children: [
                        
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
                  "Any changes you want to make?",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 186, 0, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),),
                        ),

                          ]
                        )
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