// ignore_for_file: prefer_const_constructors

import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:flutter/material.dart';
import 'am_pm.dart';
import 'hours.dart';
import 'minutes.dart';
import 'tile.dart';
import 'package:intl/intl.dart';

class CustomTimePicker extends StatelessWidget {
  int interval = 1;
  CustomTimePicker(
      {Key? key,
      this.interval = 1,
      required this.controller,
      this.indexHrsSelected = 0,
      this.indexMinSelected = 0,
      this.indexAMPMSelected = 0,
      this.onRefresh,
      this.displayTimeText = "",
      required this.hrsData,
      required this.minController,
      required this.minutesData})
      : super(key: key);

  FixedExtentScrollController controller;
  FixedExtentScrollController minController;
  int indexHrsSelected = 0;
  int indexMinSelected = 0;
  int indexAMPMSelected = 0;
  var hrsData = [];
  var minutesData = [];
  Function(int, int, int, String)? onRefresh;
  String displayTimeText = "";
  setup() {
    print("CustomTimePicker${interval}");
    cal();
    hrsSetup();
    minutesSetup();
    controller = FixedExtentScrollController();
    WidgetsBinding.instance.addPostFrameCallback(initListData);
  }

  hrsSetup() {
    for (var i = 1; i <= 12; i += 1) {
      if (10 > i) {
        hrsData.add("0${i}");
      } else {
        hrsData.add("${i}");
      }
    }
  }

  minutesSetup() {
    for (var i = 0; i < 60; i += 1) {
      if (10 > i) {
        minutesData.add("0${i}");
      } else {
        minutesData.add("${i}");
      }
    }
  }

  initListData(_) async {
    var StartTime = DateTime.utc(2022, 01, 01, 03, 30);
    print(StartTime);
    print(interval);
    var intervalTemp = Duration(minutes: interval);
    var endTime = StartTime.add(intervalTemp);
    print(endTime);
    //_controller.jumpToItem(8);
    // var midnight = DateTime.utc(2022, 1, 1);
    // const interval = Duration(minutes: 15);
    // var start = midnight.add(interval * 1);
    // var start = midnight.add(interval * 1);
  }

  String getTimeRange(int i) {
    var midnight = DateTime.utc(2022, 1, 1);
    const interval = Duration(minutes: 15);
    var start = midnight.add(interval * i);
    var end = start.add(interval);
    var formatTime = DateFormat('HH:mm').format;
    return '${formatTime(start)}-${formatTime(end)}';
  }

  void cal() {
    var slots = [
      for (var i = 0; i < 8; i += 1)
        <String, dynamic>{
          'id': i + 1,
          'time': getTimeRange(i),
          'slotNumber': '${i + 1}'.padLeft(2, '0'),
          'clicked': false,
        },
    ];

    slots.forEach(print);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // hours wheel
            Container(
              width: 30,
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 38,
                perspective: 0.005,
                diameterRatio: 1.2,
                onSelectedItemChanged: (value) {
                  print(value);
                  //  setState(() {
                  indexHrsSelected = value;
                  //  });
                  makeTimeFormat();
                },
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: hrsData.length,
                  builder: (context, index) {
                    return MyHours(
                      hours: index,
                      txt: hrsData[index],
                      selectedHrs: indexHrsSelected,
                    );
                  },
                ),
              ),
            ),

            SizedBox(
              width: 10,
            ),

            // minutes wheel
            Container(
              width: 30,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 38,
                perspective: 0.005,
                diameterRatio: 1.2,
                controller: minController,
                onSelectedItemChanged: (value) {
                  print(value);
                  ////  setState(() {
                  indexMinSelected = value;
                  //   });
                  makeTimeFormat();
                },
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: minutesData.length,
                  builder: (context, index) {
                    return MyMinutes(
                      mins: index,
                      txt: minutesData[index],
                      selectedMins: indexMinSelected,
                    );
                  },
                ),
              ),
            ),

            SizedBox(
              width: 10,
            ),

            // am or pm
            // Container(
            //   width: 50,
            //   child: ListWheelScrollView.useDelegate(
            //     itemExtent: 38,
            //     perspective: 0.005,
            //     diameterRatio: 1.2,
            //     onSelectedItemChanged: (value) {
            //       print(value);
            //       //  setState(() {
            //       indexAMPMSelected = value;
            //       // });
            //       makeTimeFormat();
            //     },
            //     physics: FixedExtentScrollPhysics(),
            //     childDelegate: ListWheelChildBuilderDelegate(
            //       childCount: 2,
            //       builder: (context, index) {
            //         if (index == 0) {
            //           return AmPm(
            //             isItAm: true,
            //             index: index,
            //             selectedAMPMIndex: indexAMPMSelected,
            //           );
            //         } else {
            //           return AmPm(
            //             isItAm: false,
            //             index: index,
            //             selectedAMPMIndex: indexAMPMSelected,
            //           );
            //         }
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
        IgnorePointer(
          ignoring: true,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Center(
              child: Container(
                height: 44,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.segmentBarSelectedColor,
                ),
                child: Center(
                  child: Text(
                    displayTimeText.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  makeTimeFormat() {
    String hr = hrsData[indexHrsSelected];
    String min = minutesData[indexMinSelected];
    String format = indexAMPMSelected == 0 ? "AM" : "PM";

    String finalTime = hr + ":" + min + " " + format;
    print(finalTime);
    onRefresh!(
        indexHrsSelected, indexMinSelected, indexAMPMSelected, finalTime);
  }
}
