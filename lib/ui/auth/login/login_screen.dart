import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/services/helper.dart';
import 'package:kisgeri24/model/authentication_bloc.dart';
import 'package:kisgeri24/model/login_bloc.dart';
import 'package:kisgeri24/ui/auth/resetPasswordScreen/reset_password_screen.dart';
import 'package:kisgeri24/ui/home/date_time_picker_screen.dart';
import 'package:kisgeri24/ui/home/home_screen.dart';
import 'package:kisgeri24/ui/loading_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
                color: isDarkMode(context) ? Colors.white : Colors.black),
            elevation: 0.0,
          ),
          body: MultiBlocListener(
            listeners: [
              loginUserAuthenticateListener(),
              loginUserLoginListener(),
            ],
            child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (old, current) =>
                  current is LoginFailureState && old != current,
              builder: (context, state) {
                if (state is LoginFailureState) {
                  _validate = AutovalidateMode.onUserInteraction;
                }
                return createForm(context);
              },
            ),
          ),
        );
      }),
    );
  }

  Form createForm(BuildContext context) {
    return Form(
                key: _key,
                autovalidateMode: _validate,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LogoImageWidget(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, right: 24.0, left: 24.0),
                        child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            validator: validateEmail,
                            onSaved: (String? val) {
                              email = val;
                            },
                            style: const TextStyle(fontSize: 18.0),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: const Color(colorPrimary),
                            decoration: getInputDecoration(
                                hint: 'Email Address',
                                darkMode: isDarkMode(context),
                                errorColor: Theme.of(context).colorScheme.error)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, right: 24.0, left: 24.0),
                        child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: true,
                            validator: validatePassword,
                            onSaved: (String? val) {
                              password = val;
                            },
                            onFieldSubmitted: (password) => context
                                .read<LoginBloc>()
                                .add(ValidateLoginFieldsEvent(_key)),
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(fontSize: 18.0),
                            cursorColor: const Color(colorPrimary),
                            decoration: getInputDecoration(
                                hint: 'Password',
                                darkMode: isDarkMode(context),
                                errorColor: Theme.of(context).colorScheme.error)),
                      ),

                      /// forgot password text, navigates user to ResetPasswordScreen
                      /// and this is only visible when logging with email and password
                      const ForgotPasswordWidget(),
                      LogInButtonWidget(keyInWidget: _key),
                      
                    ],
                  ),
                ),
              );
  }

  BlocListener<LoginBloc, LoginState> loginUserLoginListener() {
    return BlocListener<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is ValidLoginFields) {
                  await context.read<LoadingCubit>().showLoading(
                      context, 'Logging in, Please wait...', false);
                  if (!mounted) return;
                  context.read<AuthenticationBloc>().add(
                        LoginWithEmailAndPasswordEvent(
                          email: email!,
                          password: password!,
                        ),
                      );
                }
              },
            ); //@
  }

  BlocListener<AuthenticationBloc, AuthenticationState> loginUserAuthenticateListener() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) async {
                await context.read<LoadingCubit>().hideLoading();
                if (state.authState == AuthState.authenticated) {
                  if (!mounted) return;

                  //In case the user is authenticated BUT did not pick a start date yet.
                  if (!state.user!.isStartDateSet) {
                      pushAndRemoveUntil(
                      context, DateTimePickerScreen(user: state.user!), false);         
                  } else {
                    pushAndRemoveUntil(
                      context, HomeScreen(user: state.user!), false);
                  }
                } 
                else if (state.authState == AuthState.didNotPayYet) {
                  showSnackBar(context, state.message ?? 'You did not pay the entry fee yet.');
                }
                else {
                  if (!mounted) return;
                  showSnackBar(context,
                      state.message ?? 'Couldn\'t login, Please try again.');
                }
              },
            );
  }
}

class LogInButtonWidget extends StatelessWidget {
  const LogInButtonWidget({
    super.key,
    required GlobalKey<FormState> keyInWidget,
  }) : _key = keyInWidget;

  final GlobalKey<FormState> _key;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 40.0, left: 40.0, top: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(
              MediaQuery.of(context).size.width / 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(colorPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: const BorderSide(
              color: Color(colorPrimary),
            ),
          ),
        ),
        child: const Text(
          'Log In',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () => context
            .read<LoginBloc>()
            .add(ValidateLoginFieldsEvent(_key)),
      ),
    );
  }
}

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          maxWidth: 720, minWidth: 200),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, right: 24),
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () =>
                push(context, const ResetPasswordScreen()),
            child: const Text(
              'Forgot password?',
              style: TextStyle(
                  color: Color(colorPrimary),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1),
            ),
          ),
        ),
      ),
    );
  }
}

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
      top: 10.0, right: 24.0, left: 24.0),
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
