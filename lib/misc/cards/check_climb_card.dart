import 'package:flutter/material.dart';
import 'package:kisgeri24/classes/results.dart';
import 'package:kisgeri24/constants.dart';

import 'package:kisgeri24/misc/database_writes.dart';
import '../../model/user.dart';

class CheckClimbedPlaceCard extends StatefulWidget {
  final ClimbedRoute climbedRoute;
  final User user;

  const CheckClimbedPlaceCard(
    {
      super.key,
      required this.climbedRoute,
      required this.user,
    }
  );

  @override
  State<StatefulWidget> createState() => _CheckClimbedPlaceCardState();
}

enum SelectedItem { climberOne, climberTwo }

class _CheckClimbedPlaceCardState extends State<CheckClimbedPlaceCard>{
  late ClimbedRoute climbedRoute;
  late User user;
  DatabaseWrites databaseWrites = DatabaseWrites();

  @override
  void initState() {
    super.initState();
    user = widget.user;
    climbedRoute = widget.climbedRoute;
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
                  Text(climbedRoute.name, style: const TextStyle(color: Color(colorPrimary), fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Points earned: ${climbedRoute.points}, doing it ${climbedRoute.best}', style: TextStyle(color: Colors.grey.shade800, fontSize: 16, fontWeight: FontWeight.w500)),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: IconButton(
                    onPressed: removeIt(), 
                    icon: const Icon(Icons.remove_circle, color: Colors.red, size: 40,),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

removeIt() {
  /** ToDo */
}
