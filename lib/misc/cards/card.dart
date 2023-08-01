import 'package:flutter/material.dart';
import 'package:kisgeri24/constants.dart';

import '../../model/user.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final int difficultyNum;
  final String diffchanger;
  final User user;

  const CustomCard(
    {
      super.key,
      required this.title,
      required this.difficultyNum,
      required this.diffchanger,
      required this.user,
    }
  );

  @override
  State<StatefulWidget> createState() => _CustomCardState();
}

enum SelectedItem { climberOne, climberTwo }

class _CustomCardState extends State<CustomCard>{
  late String difficulty;
  late String title;
  late User user;
  SelectedItem selectedItem = SelectedItem.climberOne;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    title = widget.title;
    difficulty = widget.difficultyNum.toString() + widget.diffchanger;
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
              subtitle: Text('Difficulty: $difficulty', style: const TextStyle(color: Color(colorPrimary), fontSize: 14)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
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
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('Climbed It', style: TextStyle(color: Color(colorPrimary), fontSize: 14)),
                        onPressed: () {/* ToDo */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
