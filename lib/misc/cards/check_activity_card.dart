import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisgeri24/classes/results.dart';
import 'package:kisgeri24/constants.dart';

import 'package:kisgeri24/misc/database_writes.dart';
import 'package:kisgeri24/model/init.dart';
import '../../blocs & events & states/results_bloc.dart';
import '../../blocs & events & states/results_events.dart';
import '../../model/user.dart';
import '../../publics.dart';
import '../../ui/climbs & more/climbs_and_more_model.dart';

class CheckActivitiesCard extends StatefulWidget {
  final DidActivity didActivity;
  final User user;
  final String climberName;

  const CheckActivitiesCard(
    {
      super.key,
      required this.didActivity,
      required this.user,
      required this.climberName,
    }
  );

  @override
  State<StatefulWidget> createState() => _CheckActivitiesCardState();
}

enum SelectedItem { climberOne, climberTwo }

class _CheckActivitiesCardState extends State<CheckActivitiesCard>{
  late DidActivity didActivity;
  late String title;
  late num points;
  late User user;
  late String climberName;
  DatabaseWrites databaseWrites = DatabaseWrites();

  @override
  void initState() {
    super.initState();
    user = widget.user;
    title = widget.didActivity.name;
    points = widget.didActivity.points;
    didActivity = widget.didActivity;
    climberName = widget.climberName;
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder( 
          side: const BorderSide(
            color: Color(colorPrimary),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.rocket_launch, color: Color(colorPrimary)),
                  Text(title, style: const TextStyle(color: Color(colorPrimary), fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Points earned: $points', style: TextStyle(color: Colors.grey.shade800, fontSize: 16, fontWeight: FontWeight.w500)),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: IconButton(
                    onPressed: () => removeIt(context, didActivity, user, climberName), 
                    icon: const Icon(Icons.remove_circle, color: Colors.red, size: 40,),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

removeIt(BuildContext context, climbOrActivity, User user, String climberName) {
  /** ToDo */
  ClimbsAndMoreModel climbsAndMoreModel = ClimbsAndMoreModel();
  climbsAndMoreModel.removeClimbOrActivity(climbOrActivity, user, climberName, '');
  getNewResults(context, user);
}

void getNewResults(BuildContext context, User user) async {
  await init.getResults(context, user); 
  BlocProvider.of<ResultsBloc>(context).add(UpdateResultsEvent(results));
}
