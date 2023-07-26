part of 'authentication_bloc.dart';

enum AuthState { firstRun, authenticated, unauthenticated }

class AuthenticationState {
  final AuthState authState;
  final User? user;
  final String? message;

  const AuthenticationState._(this.authState, {this.user, this.message});

  const AuthenticationState.authenticated(User user)
      : this._(AuthState.authenticated, user: user);

      

  const AuthenticationState.unauthenticated({String? message})
      : this._(AuthState.unauthenticated,
            message: message ?? 'Unauthenticated');

  //Create an event for this.
  const AuthenticationState.didNotPay({String? message})
      : this._(AuthState.unauthenticated,
            message: message ?? 'You did not pay the entry fee yet.');

  const AuthenticationState.onboarding() : this._(AuthState.firstRun);
}
