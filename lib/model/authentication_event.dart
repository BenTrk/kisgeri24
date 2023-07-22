part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class LoginWithEmailAndPasswordEvent extends AuthenticationEvent {
  String email;
  String password;

  LoginWithEmailAndPasswordEvent({required this.email, required this.password});
}

class SignupWithEmailAndPasswordEvent extends AuthenticationEvent {
  String emailAddress;
  String password;
  String teamName;
  String firstClimberName;
  String secondClimberName;
  String category;

  SignupWithEmailAndPasswordEvent(
      {required this.emailAddress,
      required this.password,
      required this.teamName,
      required this.firstClimberName,
      required this.secondClimberName,
      required this.category
      });
}

class LogoutEvent extends AuthenticationEvent {
  LogoutEvent();
}

class FinishedOnBoardingEvent extends AuthenticationEvent {}

class CheckFirstRunEvent extends AuthenticationEvent {}
