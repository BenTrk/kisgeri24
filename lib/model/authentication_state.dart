part of 'authentication_bloc.dart';

enum AuthState { firstRun, authenticated, unauthenticated, outOfDateTimeRange, didNotPayYet }

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

  const AuthenticationState.onboarding() : this._(AuthState.firstRun);

  const AuthenticationState.outOfDateTimeRange({required User user, String? message})
      : this._(AuthState.outOfDateTimeRange, user: user,
            message: message ?? 'This is not the time to climb yet.');

//This is not set currently
  const AuthenticationState.didNotPayYet({required User user, message})
      : this._(AuthState.didNotPayYet, user: user,
            message: message ?? 'You did not pay the entry fee yet.');
}
