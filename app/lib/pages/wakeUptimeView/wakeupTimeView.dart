import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/timePickerComponent/homepage.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/ApisManager/Apis.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/TimeModel.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WakeUpTimeViewScreen extends StatefulWidget {
  bool? fromSetting;

  WakeUpTimeViewScreen({Key? key, this.fromSetting = false}) : super(key: key);

  @override
  State<WakeUpTimeViewScreen> createState() => _WakeUpTimeViewScreenState();
}

class _WakeUpTimeViewScreenState extends State<WakeUpTimeViewScreen> {
  late FixedExtentScrollController scrollController;
  List<TimeModel> hrsData = [];
  List<TimeModel> minutesData = [];
  var manager = TaskManager();
  var timecController = FixedExtentScrollController();
  var minController = FixedExtentScrollController();
  var interval = 1;
  int indexHrsSelected = 0;
  int indexMinSelected = 0;
  int indexAMPMSelected = 0;
  var displayTimeText = "";

  var finalTime = "09:00";

  var howOften = "once";
  var howLong = "1m";
  var stime = "";
  var etime = "";
  var stime24 = "";
  var etime24 = "";
  var _dateYYYYMMDD = "";
  var utcDateTime = "";
  //DateTime? calenderDefaultDate;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    hrsSetup();
    minutesSetup();
    setup();
    timecController = FixedExtentScrollController();
    minController = FixedExtentScrollController();

    //calenderDefaultDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setup();
    });
  }

  hrsSetup() {
    for (var i = 1; i <= 23; i += 1) {
      TimeModel obj = TimeModel();
      obj.enable = true;
      if (10 > i) {
        obj.title = "0${i}";
        //hrsData.add("0${i}");
      } else {
        obj.title = "${i}";
        //hrsData.add("${i}");
      }

      hrsData.add(obj);
    }
    print("hrsData ${hrsData.length}");
  }

  minutesSetup() {
    for (var i = 0; i < 60; i += 1) {
      TimeModel obj = TimeModel();
      obj.enable = true;
      if (10 > i) {
        obj.title = "0${i}";
        //  minutesData.add("0${i}");
      } else {
        obj.title = "${i}";
        // minutesData.add("${i}");
      }
      minutesData.add(obj);
    }
  }

  setup() async {
    var savedTime = await LocalStore().getWakeTime();
    print("savedTime$savedTime");
    if (savedTime != "") {
      var ff = savedTime.split(":");
      var hr = ff[0].trim();
      var min = ff[1].trim();
      print("min savedTime$min");
      int min2 = int.parse(min);
      for (var i = 0; i < minutesData.length; i++) {
        int min1 = int.parse(minutesData[i].title);

        if (min2 == min1) {
          indexMinSelected = i;

          break;
        }
      }
      for (var i = 0; i < hrsData.length; i++) {
        if (hr == hrsData[i].title) {
          indexHrsSelected = i;
          break;
        }
      }
      // indexHrsSelected = int.parse(hr);
      // indexMinSelected = int.parse(min);
      // if (indexMinSelected <= 30) {
      //   indexMinSelected = indexMinSelected - 1;
      // }
      print("indexHrsSelected$indexHrsSelected}");
      print("indexMinSelected$indexMinSelected}");
      timecController.jumpToItem(indexHrsSelected);

      minController.jumpToItem(indexMinSelected);
      setState(() {});
    } else {
      indexHrsSelected = 7;
      indexMinSelected = 31;
      timecController.jumpToItem(indexHrsSelected);
      minController.jumpToItem(indexMinSelected);
      setState(() {});
    }
  }

  calculateTimeUseInterval({needHideSomeIndex = false, index = 0}) async {
    displayTimeText = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: "What time do you wake up?",
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(),
        ),
      )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.5,
            //   child: CupertinoDatePicker(
            //     mode: CupertinoDatePickerMode.time,
            //     initialDateTime: date,
            //     onDateTimeChanged: (DateTime newDateTime) {
            //       // var newTod = TimeOfDay.fromDateTime(newDateTime);
            //       // _updateTimeFunction(newTod);
            //     },
            //     use24hFormat: false,
            //     //  minuteInterval: 1,
            //   ),
            // ),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: CustomTimePicker(
                  interval: interval,
                  controller: timecController,
                  minController: minController,
                  displayTimeText: displayTimeText,
                  wakeUpTimeEnabled: true,
                  hrsData: hrsData,
                  minutesData: minutesData,
                  indexAMPMSelected: indexAMPMSelected,
                  indexHrsSelected: indexHrsSelected,
                  indexMinSelected: indexMinSelected,
                  onRefresh: (indexHrsSelectedTemp, indexMinSelectedTemp,
                      indexAMPMSelectedTemp, finalTime) {
                    setState(() {
                      indexHrsSelected = indexHrsSelectedTemp;
                      indexMinSelected = indexMinSelectedTemp;
                      indexAMPMSelected = indexAMPMSelectedTemp;
                    });
                    calculateTimeUseInterval();
                  },
                )),
            Spacer(),
            CustomButton.regular(
              title: "Set WakeUp Time",
              onTap: () async {
                var hr = hrsData[indexHrsSelected].title;
                var time = minutesData[indexMinSelected].title;
                var finalWk = hr + ":" + time;
                print("finalWk${finalWk}");
                finalWk = TaskManager().generateUtcTime(time: finalWk);
                TaskApiManager()
                    .getSetWakeUpTime(needUpdate: true, value: finalWk);
                await LocalStore().setWake(finalWk);
                if (widget.fromSetting == true) {
                  Constant.taskProvider.startTaskFetchFromDB();
                  Navigator.of(context).pop();
                  return;
                }
                Routes.pushSimple(
                    context: context, child: Routes.setScheduleScreen());
              },
            ),
            const SizedBox(
              height: 50,
            ),
            //
          ]),
    );
  }
}
