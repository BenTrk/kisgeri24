import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kisgeri24/services/authenticator.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final Auth auth;

  ResetPasswordCubit(this.auth) : super(ResetPasswordInitial());

  resetPassword(String email) async {
    await auth.resetPassword(email);
    emit(ResetPasswordDone());
  }

  checkValidField(GlobalKey<FormState> key) {
    if (key.currentState?.validate() ?? false) {
      key.currentState!.save();
      emit(ValidResetPasswordField());
    } else {
      emit(ResetPasswordFailureState(errorMessage: 'Invalid email address.'));
    }
  }
}
