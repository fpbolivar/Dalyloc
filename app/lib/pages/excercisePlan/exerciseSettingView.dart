import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/bookingLinkScreen.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/timeSlotsAvailabilty.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/Apis/PrayerApis.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerSettingModel.dart';
import 'package:daly_doc/pages/excercisePlan/manager/exerciseApi.dart';
import 'package:daly_doc/pages/excercisePlan/model/exerciseTimeSetting.dart';
import 'package:daly_doc/pages/excercisePlan/physicalActivityLevelView.dart';
import 'package:daly_doc/pages/settingsScreen/components/sectionRowListView.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import '../../../../../utils/exportPackages.dart';
import '../../../../../utils/exportScreens.dart';
import '../../../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class ExerciseSettingView extends StatefulWidget {
  String? red;
  bool? isAdd;
  ExerciseSettingView({Key? key, this.red, this.isAdd = false})
      : super(key: key);

  @override
  State<ExerciseSettingView> createState() => _ExerciseSettingViewState();
}

class _ExerciseSettingViewState extends State<ExerciseSettingView> {
  bool getData = false;
  bool borderEnable = true;
  @override
  void initState() {
    super.initState();
    data = ExerciseTimeSettingModel(
        exercise_end_time: "", exercise_notify: "0", exercise_start_time: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isAdd == false) {
        getPrayerSetting();
      }
    });
  }

  List<SettingOption> onlineItemOption = [
    SettingOption(title: "Notifications", section: 0, type: SettingType.toggle),
  ];

  List<SettingOption> prayerOption = [
    SettingOption(
        title: "Start Time", section: 1, type: SettingType.time, time: ""),
    SettingOption(
        title: "End time", section: 1, type: SettingType.time, time: ""),
  ];
  ExerciseTimeSettingModel? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: LocalString.lblExerciseSetting,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton.regular(
            title: widget.isAdd == true ? "Next" : "Save",
            onTap: () async {
              var mgr = TaskManager();

              var stime = prayerOption[0].time;
              var etime = prayerOption[1].time;

              if (widget.isAdd == true) {
                if (stime == "") {
                  ToastMessage.showErrorwMessage(
                      msg: "Select start time of Workout");
                  return;
                }
                if (etime == "") {
                  ToastMessage.showErrorwMessage(
                      msg: "Select end time of Workout");
                  return;
                }
              }

              var stimeUTC = "";
              var etimeUTC = "";
              if (stime != "" || etime != "") {
                stime = TaskManager().convertTo24hrs(stime!);
                etime = TaskManager().convertTo24hrs(etime!);
                stimeUTC = mgr.generateUtcTime(time: stime);
                etimeUTC = mgr.generateUtcTime(time: etime);
              }

              print("stime ${stime}  ${stimeUTC}");
              print("etime ${etime}  ${etimeUTC}");
              bool value = onlineItemOption[0].value!;
              await ExerciseAPI().exerciseSetting(
                exercise_start_time: stimeUTC,
                exercise_end_time: etimeUTC,
                exercise_notify: value ? "1" : "0",
              );

              if (widget.isAdd == true) {
                Routes.pushSimple(
                    context: context, child: PhysicalActivityLevelView());
              }
            },
          ),
        ),
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

  getPrayerSetting() async {
    data = await ExerciseAPI().getExerciseSetting();
    if (data == null) {
      //onlineItemOption[0].value = false;
    } else {
      onlineItemOption[0].value =
          data!.exercise_notify.toString() == "1" ? true : false;

      var mgr = TaskManager();

      var stime = data!.exercise_start_time;

      var etime = data!.exercise_end_time;

      print("stime$stime");
      print("etime$etime");

      // if (etime == "") {
      //   prayerOption[0].time = etime;
      // }
      // if (stime != "") {
      //   prayerOption[1].time = stime;
      // }
      var stimeLocal = mgr.generateLocalTime(time: stime);
      var etimeLocal = mgr.generateLocalTime(time: etime);
      if (!Constant.HRS24FORMAT) {
        etimeLocal = mgr.timeFromStr12Hrs(etimeLocal);
      }
      if (!Constant.HRS24FORMAT) {
        stimeLocal = mgr.timeFromStr12Hrs(stimeLocal);
      }

      prayerOption[0].time = stimeLocal;
      prayerOption[1].time = etimeLocal;
    }

    setState(() {});
  }

  setNotification(String value) async {
    bool? status = await PrayerApis().prayerSetting(isNotificationValue: value);
    if (status == null || status == false) {
      //onlineItemOption[0].value = false;
    } else {
      //onlineItemOption[0].value = true;
    }
    setState(() {});
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: onlineItemOption,
                  borderEnable: borderEnable,
                  onSelectionBool: ((boolValue, p1, p2) {
                    onlineItemOption[p2].value = boolValue;
                    //setNotification(boolValue ? "1" : "0");
                    setState(() {});
                  }),
                  onTap: (sectionIndex, rowIndex) {
                    switch (rowIndex) {
                      case 0:
                        break;
                      case 1:
                        break;

                      default:
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: prayerOption,
                  onTap: (sectionIndex, rowIndex) {
                    // rowIndex == 0
                    //     ? Routes.pushSimple(
                    //         context: context,
                    //         child: (

                    //         ))
                    //     : Routes.pushSimple(
                    //         context: context,
                    //         child: TimeSlotsAvailabiltyScreens());
                  }),
              const SizedBox(
                height: 20,
              ),
            ]),
      ),
    );
  }
}
