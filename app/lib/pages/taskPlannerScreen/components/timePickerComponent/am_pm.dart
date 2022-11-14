// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AmPm extends StatelessWidget {
  final bool isItAm;
  int selectedAMPMIndex;
  int index;
  AmPm({required this.isItAm, this.selectedAMPMIndex = 0, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: Center(
          child: Text(
            isItAm == true ? 'AM' : 'PM',
            style: TextStyle(
              fontSize: selectedAMPMIndex == index ? 24 : 20,
              color: selectedAMPMIndex == index ? Colors.white : Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
