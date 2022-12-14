// ignore_for_file: prefer_const_constructors

import 'package:daly_doc/pages/taskPlannerScreen/components/timePickerComponent/wakeUpHourItem.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/timePickerComponent/wakeUpMinutesItem.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/TimeModel.dart';
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
      this.ampmController,
      required this.controller,
      this.indexHrsSelected = 0,
      this.need12HrsFormat = false,
      this.wakeUpTimeEnabled = false,
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
  FixedExtentScrollController? ampmController;

  int indexHrsSelected = 0;
  bool? wakeUpTimeEnabled;
  int indexMinSelected = 0;
  int indexAMPMSelected = 0;
  bool need12HrsFormat = false;
  List<TimeModel> hrsData = [];
  List<TimeModel> minutesData = [];
  Function(int, int, int, String)? onRefresh;
  String displayTimeText = "";
  setup() {
    print("CustomTimePicker${interval}");
    cal();
    // hrsSetup();
    //minutesSetup();
    controller = FixedExtentScrollController();
    WidgetsBinding.instance.addPostFrameCallback(initListData);
  }

  hrsSetup() {
    //hrsData =
    // for (var i = 1; i <= 12; i += 1) {
    //   if (10 > i) {
    //     hrsData.add("0${i}");
    //   } else {
    //     hrsData.add("${i}");
    //   }
    // }
  }

  minutesSetup() {
    // for (var i = 0; i < 60; i += 1) {
    //   if (10 > i) {
    //     minutesData.add("0${i}");
    //   } else {
    //     minutesData.add("${i}");
    //   }
    // }
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
                    return wakeUpTimeEnabled == true
                        ? WakeHoursItem(
                            hours: index,
                            txt: hrsData[index].title,
                            selectedHrs: indexHrsSelected,
                          )
                        : MyHours(
                            hours: index,
                            enable: hrsData[index].enable!,
                            txt: hrsData[index].title,
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
                    return wakeUpTimeEnabled == true
                        ? WakeUpHourItem(
                            mins: index,
                            txt: minutesData[index].title,
                            selectedMins: indexMinSelected,
                          )
                        : MyMinutes(
                            mins: index,
                            enable: minutesData[index].enable!,
                            txt: minutesData[index].title,
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
            if (need12HrsFormat)
              Container(
                width: 50,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 38,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  controller: ampmController,
                  onSelectedItemChanged: (value) {
                    print(value);
                    //  setState(() {
                    indexAMPMSelected = value;
                    // });
                    makeTimeFormat();
                  },
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 2,
                    builder: (context, index) {
                      if (index == 0) {
                        return AmPm(
                          isItAm: true,
                          index: index,
                          selectedAMPMIndex: indexAMPMSelected,
                        );
                      } else {
                        return AmPm(
                          isItAm: false,
                          index: index,
                          selectedAMPMIndex: indexAMPMSelected,
                        );
                      }
                    },
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  makeTimeFormat() {
    String hr = hrsData[indexHrsSelected].title;
    String min = minutesData[indexMinSelected].title;
    String format = indexAMPMSelected == 0 ? "AM" : "PM";
    print("MINNNNN$min");
    print("MINNNNN$indexMinSelected");
    String finalTime = hr + ":" + min + " " + format;
    print(finalTime);
    onRefresh!(
        indexHrsSelected, indexMinSelected, indexAMPMSelected, finalTime);
  }
}
