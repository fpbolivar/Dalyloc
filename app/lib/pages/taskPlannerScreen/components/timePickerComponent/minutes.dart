// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyMinutes extends StatelessWidget {
  int mins;
  int selectedMins;
  String txt;
  bool enable;
  MyMinutes(
      {required this.mins,
      this.selectedMins = 0,
      this.txt = "",
      this.enable = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: Center(
          child: Text(
            txt.toString(),
            style: TextStyle(
              fontSize: mins == selectedMins ? 24 : 20,
              color: enable
                  ? mins == selectedMins
                      ? Colors.transparent
                      : Colors.black
                  : Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
