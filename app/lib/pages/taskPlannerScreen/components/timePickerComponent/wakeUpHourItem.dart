// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WakeHoursItem extends StatelessWidget {
  int hours;
  String txt;

  int selectedHrs;

  WakeHoursItem({
    required this.hours,
    this.selectedHrs = 0,
    this.txt = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: Center(
          child: Text(
            txt.toString(),
            style: TextStyle(
              fontSize: hours == selectedHrs ? 24 : 20,
              color: hours == selectedHrs ? Colors.white : Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
