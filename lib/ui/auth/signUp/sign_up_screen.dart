import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/model/sign_up_bloc.dart';
import 'package:kisgeri24/ui/home/home_screen.dart';
import 'package:kisgeri24/ui/loading_cubit.dart';
import 'package:kisgeri24/misc/toggle_buttons_signup.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../publics.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  String? firstClimberName,
      secondClimberName,
      email,
      password,
      confirmPassword,
      teamName;
  bool isPaid = false;
  AutovalidateMode _validate = AutovalidateMode.disabled;
  bool acceptEULA = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: Builder(
        builder: (context) {
          if (!kIsWeb && Platform.isAndroid) {
            context.read<SignUpBloc>().add(RetrieveLostDataEvent());
          }
          return MultiBlocListener(
            listeners: [
              loginUserAuthenticationListener(),
              loginUserLoginListener(),
            ],
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(
                    color: isDarkMode(context) ? Colors.white : Colors.black),
              ),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (old, current) =>
                      current is SignUpFailureState && old != current,
                  builder: (context, state) {
                    if (state is SignUpFailureState) {
                      _validate = AutovalidateMode.onUserInteraction;
                    }
                    return createForm(context);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Form createForm(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode: _validate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ImageWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: validateName,
              onSaved: (String? val) {
                firstClimberName = val;
              },
              textInputAction: TextInputAction.next,
              decoration: getInputDecoration(
                  hint: 'First Climber\'s Name',
                  darkMode: isDarkMode(context),
                  errorColor: Theme.of(context).colorScheme.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: validateName,
              onSaved: (String? val) {
                secondClimberName = val;
              },
              textInputAction: TextInputAction.next,
              decoration: getInputDecoration(
                  hint: 'Second Climber\'s Name',
                  darkMode: isDarkMode(context),
                  errorColor: Theme.of(context).colorScheme.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: validateEmail,
              onSaved: (String? val) {
                email = val;
              },
              decoration: getInputDecoration(
                  hint: 'Email',
                  darkMode: isDarkMode(context),
                  errorColor: Theme.of(context).colorScheme.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: validateName,
              onSaved: (String? val) {
                teamName = val;
              },
              textInputAction: TextInputAction.next,
              decoration: getInputDecoration(
                  hint: 'Team\'s Name',
                  darkMode: isDarkMode(context),
                  errorColor: Theme.of(context).colorScheme.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
            child: TextFormField(
              obscureText: true,
              textInputAction: TextInputAction.next,
              controller: _passwordController,
              validator: validatePassword,
              onSaved: (String? val) {
                password = val;
              },
              cursorColor: const Color(colorPrimary),
              decoration: getInputDecoration(
                  hint: 'Password',
                  darkMode: isDarkMode(context),
                  errorColor: Theme.of(context).colorScheme.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => context.read<SignUpBloc>().add(
                    ValidateFieldsEvent(_key, acceptEula: acceptEULA),
                  ),
              obscureText: true,
              validator: (val) =>
                  validateConfirmPassword(_passwordController.text, val),
              onSaved: (String? val) {
                confirmPassword = val;
              },
              cursorColor: const Color(colorPrimary),
              decoration: getInputDecoration(
                  hint: 'Confirm Password',
                  darkMode: isDarkMode(context),
                  errorColor: Theme.of(context).colorScheme.error),
            ),
          ),
          getCategory(),
          getSignUpButton(context),
          const SizedBox(height: 24),
          getTermsOfUse(),
        ],
      ),
    );
  }

  ListTile getTermsOfUse() {
    return ListTile(
      trailing: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (old, current) =>
            current is EulaToggleState && old != current,
        builder: (context, state) {
          if (state is EulaToggleState) {
            acceptEULA = state.eulaAccepted;
          }
          return Checkbox(
            onChanged: (value) => context.read<SignUpBloc>().add(
                  ToggleEulaCheckboxEvent(
                    eulaAccepted: value!,
                  ),
                ),
            activeColor: const Color(colorPrimary),
            value: acceptEULA,
          );
        },
      ),
      title: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'By creating an account you agree to our ',
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
              style: const TextStyle(
                color: Colors.blueAccent,
              ),
              text: 'Terms of Use',
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (await canLaunchUrl(Uri.parse(eula))) {
                    await launchUrl(
                      Uri.parse(eula),
                    );
                  }
                },
            ),
          ],
        ),
      ),
    );
  }

  Padding getSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(MediaQuery.of(context).size.width / 1.5),
          backgroundColor: const Color(colorPrimary),
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: const BorderSide(
              color: Color(colorPrimary),
            ),
          ),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () => context.read<SignUpBloc>().add(
              ValidateFieldsEvent(_key, acceptEula: acceptEULA),
            ),
      ),
    );
  }

  Padding getCategory() {
    return const Padding(
        padding: EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
        child: (CustomToggleButtons()));
  }

  BlocListener<SignUpBloc, SignUpState> loginUserLoginListener() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) async {
        if (state is ValidFields) {
          await context.read<LoadingCubit>().showLoading(
              context, 'Creating new account, Please wait...', false);
          if (!mounted) return;
          context.read<AuthenticationBloc>().add(
              SignupWithEmailAndPasswordEvent(
                  emailAddress: email!,
                  password: password!,
                  teamName: teamName!,
                  firstClimberName: firstClimberName!,
                  secondClimberName: secondClimberName!,
                  category: category));
        } else if (state is SignUpFailureState) {
          showSnackBar(context, state.errorMessage);
        }
      },
    );
  }

  BlocListener<AuthenticationBloc, AuthenticationState>
      loginUserAuthenticationListener() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        context.read<LoadingCubit>().hideLoading();
        if (state.authState == AuthState.authenticated) {
          pushAndRemoveUntil(context, HomeScreen(user: state.user!), false);
        } else {
          showSnackBar(
              context, state.message ?? 'Couldn\'t sign up, Please try again.');
        }
      },
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0, left: 24.0),
      child: Image.asset(
        'assets/images/welcome_image.png',
        alignment: Alignment.center,
        width: 150.0,
        height: 150.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
