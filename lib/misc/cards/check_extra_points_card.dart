import 'package:flutter/material.dart';
import 'package:kisgeri24/classes/results.dart';
import 'package:kisgeri24/constants.dart';

import '../../data/models/user.dart';

class CheckExtraPointsCard extends StatefulWidget {
  final TeamResult teamResult;
  final User user;

  const CheckExtraPointsCard({
    super.key,
    required this.user,
    required this.teamResult,
  });

  @override
  State<StatefulWidget> createState() => _CheckExtraPointsCardState();
}

class _CheckExtraPointsCardState extends State<CheckExtraPointsCard> {
  @override
  void initState() {
    super.initState();
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
                const Icon(Icons.star, color: Color(colorPrimary)),
                Text(widget.teamResult.action,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Points earned: ${widget.teamResult.points}',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
