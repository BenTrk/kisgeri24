import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/screens/overview/overview_bloc.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Overview')),
        body: BlocBuilder<OverviewBloc, OverviewState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            } else if (state is LoadedState) {
              return YourCustomWidget(data: state.data);
            } else if (state is ErrorState) {
              return Text('Error: ${state.errorMessage}');
            }
            return const Text('Initial State');
          },
        ),
      ),
    );
  }
}