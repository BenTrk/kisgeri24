import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kisgeri24/constants.dart';

import 'package:kisgeri24/misc/database_writes.dart';

import '../../model/user.dart';
import '../../publics.dart';

class ActivitiesCard extends StatefulWidget {
  final String title;
  final Map<String, int> valueMap;
  final User user;
  final String category;

  const ActivitiesCard(
    {
      super.key,
      required this.title,
      required this.valueMap,
      required this.user,
      required this.category,
    }
  );

  @override
  State<StatefulWidget> createState() => _ActivitiesCardState();
}

enum SelectedItem { climberOne, climberTwo }

class _ActivitiesCardState extends State<ActivitiesCard>{
  late Map<String, int> valueMap;
  late String title;
  late User user;
  bool isTeam = false;
  SelectedItem selectedItem = SelectedItem.climberOne;
  String pointsSelected = '0';
  String? selectedItemKey;
  String? selectedItemValue;
  DatabaseWrites databaseWrites = DatabaseWrites();

  @override
  void initState() {
    super.initState();
    user = widget.user;
    title = widget.title;
    valueMap = widget.valueMap;
    if (widget.category == 'Teams'){
      isTeam = true;
    } else {
      isTeam = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder( //<-- SEE HERE
          side: const BorderSide(
            color: Color(colorPrimary),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.rocket_launch, color: Color(colorPrimary)),
              title: Text(title, style: const TextStyle(color: Color(colorPrimary), fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                !isTeam 
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        ToggleButtons(
                          fillColor: const Color(colorPrimary),
                          selectedColor: Colors.white,
                          color: const Color(colorPrimary),
                          selectedBorderColor: const Color(colorPrimary),
                          borderColor: const Color(colorPrimary),
                          borderRadius: BorderRadius.circular(5),
                          isSelected: widget.valueMap.keys.map((key) => key == selectedItemValue).toList(),
                          onPressed: (index) {
                            setState(() {
                              selectedItemValue = widget.valueMap.keys.toList()[index];
                              log(selectedItemValue.toString());
                            });
                          },
                          children: widget.valueMap.keys.map((key) => Text(key)).toList(),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleButtons(
                              fillColor: const Color(colorPrimary),
                              selectedColor: Colors.white,
                              color: const Color(colorPrimary),
                              selectedBorderColor: const Color(colorPrimary),
                              borderColor: const Color(colorPrimary),
                              borderRadius: BorderRadius.circular(5),
                              // List of booleans to specify whether each button is selected or not
                              isSelected: [
                                selectedItem == SelectedItem.climberOne,
                                selectedItem == SelectedItem.climberTwo,
                              ],
                              // Callback when the user taps on a button
                              onPressed: (index) {
                                setState(() {
                                // Update the selectedItem based on the button tapped
                                selectedItem = index == 0 ? SelectedItem.climberOne : SelectedItem.climberTwo;
                                });
                              },
                              children: [
                                Text(user.firstClimberName),
                                Text(user.secondClimberName),
                              ],
                            ),
                            const SizedBox(width: 8),TextButton(
                                  child: const Text('Did it!', style: TextStyle(color: Color(colorPrimary), fontSize: 14)),
                                  onPressed: () {
                                    if (!results.pausedHandler.isPaused){
                                      List<String> names = [user.firstClimberName, user.secondClimberName];
                                      if (selectedItemValue != null){
                                        databaseWrites.writeActivityToDatabase(context, user, names[selectedItem.index], title, valueMap[selectedItemValue]!);
                                      }
                                    } //else say nooooo
                                  },
                                ),
                            
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(decoration: BoxDecoration(
                      color: const Color(colorPrimary),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Points will be given by judges.', 
                          style: TextStyle(color: Colors.white, fontSize: 14)
                        ),
                      ),
                    )
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
