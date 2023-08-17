import 'package:flutter/material.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/publics.dart';

class CustomToggleButtons extends StatefulWidget {
  const CustomToggleButtons({super.key});

  @override
  CustomToggleButtonsState createState() => CustomToggleButtonsState();
}

class CustomToggleButtonsState extends State<CustomToggleButtons> {
  final List<bool> _isSelected = [false, true, false];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Category: ",
            style: TextStyle(color: Colors.grey.shade700),
          ),
          ToggleButtons(
            isSelected: _isSelected,
            onPressed: (int index) {
              setState(() {
                _isSelected[index] = !_isSelected[index];
                category = categories[index];
                for (int i = 0; i < _isSelected.length; i++) {
                  if (_isSelected[i] == true && i != index) {
                    _isSelected[i] = false;
                  }
                }
              });
            },
            // region example 1
            color: Colors.grey.shade700,
            selectedColor: Colors.white,
            fillColor: const Color(colorPrimary),
            // endregion
            // region example 2
            borderColor: Colors.grey.shade200,
            selectedBorderColor: const Color(colorPrimary),
            borderRadius: const BorderRadius.all(Radius.circular(10)),

            children: <Widget>[
              Text(categories[0]),
              Text(categories[1]),
              Text(
                categories[2],
              )
            ],
            // endregion
          ),
        ],
      ),
    );
  }
}
