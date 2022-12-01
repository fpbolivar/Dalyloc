import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/bookingLinkScreen.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/timeSlotsAvailabilty.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/Apis/PrayerApis.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerSettingModel.dart';
import 'package:daly_doc/pages/settingsScreen/components/sectionRowListView.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import '../../../../../utils/exportPackages.dart';
import '../../../../../utils/exportScreens.dart';
import '../../../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class DevotionalPlanSetting extends StatefulWidget {
  String? red;
  DevotionalPlanSetting({
    Key? key,
    this.red,
  }) : super(key: key);

  @override
  State<DevotionalPlanSetting> createState() => _DevotionalPlanSettingState();
}

class _DevotionalPlanSettingState extends State<DevotionalPlanSetting> {
  bool getData = false;
  bool borderEnable = true;
  @override
  void initState() {
    super.initState();
    data = PrayerSettingModel(
        paryer_daily_count: 1,
        prayer_end_time: "",
        prayer_notify: "0",
        prayer_start_time: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPrayerSetting();
    });
  }

  List<SettingOption> onlineItemOption = [
    SettingOption(title: "Notifications", section: 0, type: SettingType.toggle),
  ];

  List<SettingOption> prayerOption = [
    SettingOption(
        title: " Daily", section: 1, type: SettingType.counter, counter: 0),
    SettingOption(
        title: "Start Time", section: 1, type: SettingType.time, time: ""),
    SettingOption(
        title: "End time", section: 1, type: SettingType.time, time: ""),
  ];
  PrayerSettingModel? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: LocalString.lblDevSettingNavTitle,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton.regular(
            title: "Save",
            onTap: () async {
              var mgr = TaskManager();
              var counter = prayerOption[0].counter;
              var stime = prayerOption[1].time;
              var etime = prayerOption[2].time;
              var stimeUTC = mgr.generateUtcTime(time: stime);
              var etimeUTC = mgr.generateUtcTime(time: etime);

              print(counter);
              print("stime ${stime}  ${stimeUTC}");
              print("etime ${etime}  ${etimeUTC}");
              await PrayerApis().prayerSetting(
                  startTime: stimeUTC,
                  endTime: etimeUTC,
                  paryer_daily_count: counter);
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
    data = await PrayerApis().getPrayerSetting();
    if (data == null) {
      //onlineItemOption[0].value = false;
    } else {
      onlineItemOption[0].value =
          data!.prayer_notify.toString() == "1" ? true : false;

      var mgr = TaskManager();

      var stime = data!.prayer_start_time;

      var etime = data!.prayer_end_time;
      var stimeLocal = mgr.generateLocalTime(time: stime);
      var etimeLocal = mgr.generateLocalTime(time: etime);

      prayerOption[0].counter = data!.paryer_daily_count;
      prayerOption[1].time = stimeLocal;
      prayerOption[2].time = etimeLocal;
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
                    setNotification(boolValue ? "1" : "0");
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
