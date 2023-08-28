import 'package:flutter/material.dart';
import 'package:kisgeri24/classes/results.dart';
import 'package:kisgeri24/constants.dart';

import 'package:kisgeri24/misc/database_writes.dart';
import 'package:kisgeri24/model/user.dart';
import 'package:kisgeri24/ui/climbs%20&%20more/climbs_and_more_model.dart';

class CheckActivitiesCard extends StatefulWidget {
  final DidActivity didActivity;
  final User user;
  final String climberName;

  const CheckActivitiesCard({
    super.key,
    required this.didActivity,
    required this.user,
    required this.climberName,
  });

  @override
  State<StatefulWidget> createState() => _CheckActivitiesCardState();

  Key? getKey() {
    return key;
  }
}

enum SelectedItem { climberOne, climberTwo }

class _CheckActivitiesCardState extends State<CheckActivitiesCard> {
  late DidActivity didActivity;
  late String title;
  late num points;
  late User user;
  late String climberName;
  DatabaseWrites databaseWrites = DatabaseWrites();
  bool isActive = true;

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
      child: isActive
          ? Card(
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
                        const Icon(Icons.rocket_launch,
                            color: Color(colorPrimary)),
                        Text(title,
                            style: const TextStyle(
                                color: Color(colorPrimary),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Points earned: $points',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: IconButton(
                          onPressed: () {
                            removeIt(context, didActivity, user, climberName);
                            setState(() {
                              isActive =
                                  false; // Set isActive to false when the remove button is pressed
                            });
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Card(
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey.shade200,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.rocket_launch, color: Colors.grey.shade200),
                    Text(title,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}

removeIt(BuildContext context, climbOrActivity, User user, String climberName) {
  /** ToDo */
  ClimbsAndMoreModel climbsAndMoreModel = ClimbsAndMoreModel();
  climbsAndMoreModel.removeClimbOrActivity(
      climbOrActivity, user, climberName, '');
}
