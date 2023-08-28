import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/ui/auth/login/login_screen.dart';

class OptionsModel {
  static enableTextField(bool isEnabled) {
    isEnabled = true;
    return isEnabled;
  }

  static changeEmail(BuildContext context, String email) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        User user = FirebaseAuth.instance.currentUser!;
        await user.updateEmail(email);
      }
    } catch (e) {
      if (e == FirebaseAuthException) {
        showSnackBar(context, 'Sign in again!');
        pushReplacement(context, const LoginScreen());
      }
    }
  }

  static void changePassword(BuildContext context, String emailToSend) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailToSend);
  }

  static void deleteUser(BuildContext context, String emailToDelete,
      String passwordToDelete) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailToDelete,
        password: passwordToDelete,
      );

      // Authentication successful
      userCredential.user?.delete();
    } on FirebaseAuthException catch (e) {
      // Handle authentication errors
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
      } else {}

      // Show an error message or handle the situation as needed
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Authentication Error'),
            content: const Text(
                'There was an error authenticating. Please check your email and password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
