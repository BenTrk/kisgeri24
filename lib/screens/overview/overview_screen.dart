import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/screens/overview/overview_bloc.dart';
import 'package:kisgeri24/screens/overview/overview_dto.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Trigger loadData() when the screen is about to be visible
      context.read<OverviewBloc>().loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('Overview')),
        body: BlocBuilder<OverviewBloc, OverviewState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              // Display your UI using the loaded data from state
              return YourCustomWidget(data: state.data);
            } else if (state is ErrorState) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }
            return Container(); // Return an empty container or initial UI state
          },
        ),
      ),
    );
  }


}

class YourCustomWidget extends StatelessWidget {
  final OverviewDto data;

  YourCustomWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Routes'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.routes
                //.map((route) => Text('${route.name} - ${route.length}'))
                .toList(),
          ),
        ),
        Divider(),
        ListTile(
          title: Text('User Points'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('${data.teamPoints}')],
          ),
        ),
        Divider(),
      ],
    );
  }
}
