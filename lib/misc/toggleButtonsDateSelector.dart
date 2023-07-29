import 'package:flutter/material.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/publics.dart';

class CustomToggleDateButtons extends StatefulWidget {
  const CustomToggleDateButtons({super.key});

    @override
    CustomToggleDateButtonsState createState() => CustomToggleDateButtonsState();
  }
  
  class CustomToggleDateButtonsState extends State<CustomToggleDateButtons> {
    final List<bool> _isSelected = [false, true];
  
    @override
    Widget build(BuildContext context) {
      return Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ToggleButtons(
                direction: Axis.vertical,
                isSelected: _isSelected,
                onPressed: (int index) {
                  setState(() {
                    _isSelected[index] = !_isSelected[index];
                    teamDate = dates[index];
                    for (int i = 0; i < _isSelected.length; i++){
                      if (_isSelected[i] == true && i != index) {
                        _isSelected[i] = false;
                      }
                    }
                  });
                },
                color: const Color(colorPrimary),
                selectedColor: Colors.white,
                fillColor: const Color(colorPrimary),
                borderColor: Colors.grey.shade100,
                selectedBorderColor: const Color(colorPrimary),
                borderRadius: const BorderRadius.all(Radius.circular(10)),

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(dates[0]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(dates[1]),
                  ),
                ],
                // endregion
              ),
            ],
          ),
        );
    }
  }