import 'package:bloc/bloc.dart';
import 'package:kisgeri24/model/init.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/services/firebase_service.dart';
import 'package:kisgeri24/services/authenticator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  User? user;

  AuthenticationBloc({this.user})
      : super(const AuthenticationState.unauthenticated()) {
    Auth authenticator = Auth(FirebaseSingletonProvider.instance.authInstance,
        FirebaseSingletonProvider.instance.firestoreInstance);
    on<CheckFirstRunEvent>((event, emit) async {
      user = await authenticator.getAuthUser();
      if (user == null) {
        emit(const AuthenticationState.unauthenticated());
      } else if (user!.isPaid == false) {
        emit(AuthenticationState.didNotPayYet(
            user: user!, message: 'You did not pay the entry fee yet.'));
      } else if (!user!.isStartDateSet) {
        emit(AuthenticationState.didNotSetTime(
            user: user!, message: 'You need to set the startdate first.'));
      } else if (!await Init.checkDateTime(user!)) {
        emit(AuthenticationState.outOfDateTimeRange(user: user!));
      } else {
        emit(AuthenticationState.authenticated(user!));
      }
    });
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      dynamic result = await authenticator.login(event.email, event.password);
      if (result != null &&
          result is User &&
          result.isPaid &&
          await Init.checkDateTime(result)) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else if (result != null && result is User && result.isPaid == false) {
        user = result;
        emit(AuthenticationState.didNotPayYet(
            user: user!, message: 'You did not pay the entry fee yet.'));
      } else if (result != null && result is User && !result.isStartDateSet) {
        user = result;
        emit(AuthenticationState.didNotSetTime(
            user: user!, message: 'You need to set the startdate first.'));
      } else if (result != null && result is User && result.isStartDateSet) {
        user = result;
        emit(AuthenticationState.outOfDateTimeRange(user: user!));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Login failed, Please try again.'));
      }
    });
    on<SignupWithEmailAndPasswordEvent>((event, emit) async {
      dynamic result = await authenticator.signUpWithEmailAndPassword(
        emailAddress: event.emailAddress,
        password: event.password,
        teamName: event.teamName,
        firstClimberName: event.firstClimberName,
        secondClimberName: event.secondClimberName,
        category: event.category,
      );
      if (result != null &&
          result is User &&
          result.isPaid &&
          await Init.checkDateTime(result)) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is User && result.isPaid == false) {
        user = result;
        emit(AuthenticationState.didNotPayYet(
            user: user!, message: 'You did not pay the entry fee yet.'));
      } else if (result != null && result is User && !result.isStartDateSet) {
        user = result;
        emit(AuthenticationState.didNotSetTime(
            user: user!, message: 'You need to set the startdate first.'));
      } else if (result != null && result is User && result.isStartDateSet) {
        user = result;
        emit(AuthenticationState.outOfDateTimeRange(user: user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Couldn\'t sign up'));
      }
    });
    on<LogoutEvent>((event, emit) async {
      await authenticator.logout();
      user = null;
      emit(const AuthenticationState.unauthenticated());
    });

    on<CheckAuthenticationEvent>((event, emit) async {
      User? user = await authenticator.getAuthUser();
      if (user != null) {
        if (await Init.checkDateTime(user)) {
          emit(AuthenticationState.authenticated(user));
        }
      } //ToDo error handling
    });
  }
}
