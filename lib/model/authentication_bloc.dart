
import 'package:bloc/bloc.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/model/user.dart';
import 'package:flutter_login_screen/services/authenticate.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  User? user;
  late SharedPreferences prefs;
  late bool finishedOnBoarding;

  AuthenticationBloc({this.user})
      : super(const AuthenticationState.unauthenticated()) {
    on<CheckFirstRunEvent>((event, emit) async {
      prefs = await SharedPreferences.getInstance();
      finishedOnBoarding = prefs.getBool(finishedOnBoardingConst) ?? false;
      if (!finishedOnBoarding) {
        emit(const AuthenticationState.onboarding());
      } else {
        user = await FireStoreUtils.getAuthUser();
        if (user == null) {
          emit(const AuthenticationState.unauthenticated());
        } else {
          emit(AuthenticationState.authenticated(user!));
        }
      }
    });
    on<FinishedOnBoardingEvent>((event, emit) async {
      await prefs.setBool(finishedOnBoardingConst, true);
      emit(const AuthenticationState.unauthenticated());
    });
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      dynamic result = await FireStoreUtils.loginWithEmailAndPassword(
          event.email, event.password);
      if (result != null && result is User) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Login failed, Please try again.'));
      }
    });

    on<SignupWithEmailAndPasswordEvent>((event, emit) async {
      dynamic result = await FireStoreUtils.signUpWithEmailAndPassword(
          emailAddress: event.emailAddress,
          password: event.password,
          teamName: event.teamName,
          firstClimberName: event.firstClimberName,
          secondClimberName: event.secondClimberName,
          category: event.category,);
      if (result != null && result is User) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Couldn\'t sign up'));
      }
    });
    on<LogoutEvent>((event, emit) async {
      await FireStoreUtils.logout();
      user = null;
      emit(const AuthenticationState.unauthenticated());
    });
  }
}
