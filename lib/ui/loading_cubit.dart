import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:kisgeri24/services/helper.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial());

  showLoading(BuildContext context, String message, bool isDismissible) async =>
      await showProgress(context, message, isDismissible);

  hideLoading() async => await hideProgress();
}
