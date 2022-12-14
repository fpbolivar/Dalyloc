import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/model/mealSettingModel.dart';
import 'package:daly_doc/pages/settingsScreen/ApiManager/AllPlansApiManager.dart';
import 'package:daly_doc/pages/settingsScreen/components/sectionRowListView.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/pages/settingsScreen/model/allPlanMode.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportScreens.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class MealSettingView extends StatefulWidget {
  String? red;
  MealSettingView({Key? key, this.red}) : super(key: key);

  @override
  State<MealSettingView> createState() => _MealSettingViewState();
}

class _MealSettingViewState extends State<MealSettingView> {
  bool getData = false;
  MealSettingModel? data;
  @override
  void initState() {
    super.initState();
    data = MealSettingModel(
        meal_daily_count: 1,
        meal_end_time: "",
        meal_notify: "0",
        meal_start_time: "");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getplanList();
      getMealSetting();
    });
  }

  List<SettingOption> mealTypeOption = [
    SettingOption(title: "Diet Type", section: 0),
    SettingOption(title: "Allergies", section: 0),
    SettingOption(title: "Dislike ingredients", section: 0),
    SettingOption(title: "Meal size", section: 0),
  ];
  List<SettingOption> paymentMethod = [
    SettingOption(title: "Payment Method", section: 3),
  ];
  List<SettingOption> mealAlertOption = [
    SettingOption(title: "Notifications", section: 1, type: SettingType.toggle),
    SettingOption(
        title: " Daily", section: 1, type: SettingType.counter, counter: 0),
    SettingOption(
        title: "Start Time", section: 1, type: SettingType.time, time: ""),
    SettingOption(
        title: "End time", section: 1, type: SettingType.time, time: ""),
    //SettingOption(title: "Reminders", section: 1),
  ];

  List<SettingOption> homeOption = [
    SettingOption(title: "Back to Home", section: 2),
  ];
  List<SettingOption> planSettingOption = [
    SettingOption(
      title: "Loading..",
      section: 2,
      type: SettingType.loading,
    ),
  ];
  MealApis manager = MealApis();
  bool isNotificationLoadStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: LocalString.lblSettingNavTitle,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton.regular(
            title: "Save",
            onTap: () async {
              var mgr = TaskManager();
              var counter = mealAlertOption[1].counter;
              var stime = mealAlertOption[2].time;
              var etime = mealAlertOption[3].time;
              stime = TaskManager().convertTo24hrs(stime!);
              etime = TaskManager().convertTo24hrs(etime!);
              print("stime ${stime} ");
              print("etime ${etime} ");

              var stimeUTC = "";
              var etimeUTC = "";
              if (stime != null && stime != "") {
                stimeUTC = mgr.generateUtcTime(time: stime);
              }
              var etimeLocal = "";
              if (etime != null && etime != "") {
                etimeUTC = mgr.generateUtcTime(time: etime);
              }

              print(counter);
              print("stime ${stime}  ${stimeUTC}");
              print("etime ${etime}  ${etimeUTC}");
              await manager.mealSetting(
                  startTime: stimeUTC,
                  endTime: etimeUTC,
                  meal_daily_count: counter);
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

  addWidgetRefresh() {
    planSettingOption = [];
    planSettingOption.add(SettingOption(
      title: "Tap to refresh",
      section: 2,
      type: SettingType.refresh,
    ));
    setState(() {});
  }

  addWidgetLoading() {
    planSettingOption = [];
    planSettingOption.add(SettingOption(
      title: "Loading..",
      section: 2,
      type: SettingType.loading,
    ));
    setState(() {});
  }

  updateNotificationLoading() {
    // if (isNotificationLoadStatus) {
    //   mealAlertOption[0].type = SettingType.loading;
    // } else {
    //   mealAlertOption[0].type = SettingType.toggle;
    // }
    // setState(() {});
  }
  getMealSetting() async {
    isNotificationLoadStatus = true;
    updateNotificationLoading();
    data = await manager.getMealSetting();
    isNotificationLoadStatus = false;
    print("------");
    print(data!.meal_notify!);
    updateNotificationLoading();
    if (data == null) {
      //onlineItemOption[0].value = false;
    } else {
      mealAlertOption[0].value =
          data!.meal_notify.toString() == "1" ? true : false;
      print(mealAlertOption[0].value);
      var mgr = TaskManager();

      var stime = data!.meal_start_time;
      print(stime);
      var etime = data!.meal_end_time;
      print(etime);
      var stimeLocal = "";
      if (stime != null && stime != "") {
        stimeLocal = mgr.generateLocalTime(time: stime);
        if (!Constant.HRS24FORMAT) {
          stimeLocal = mgr.timeFromStr12Hrs(stimeLocal);
        }
      }
      var etimeLocal = "";
      if (etime != null && etime != "") {
        etimeLocal = mgr.generateLocalTime(time: etime);
        if (!Constant.HRS24FORMAT) {
          etimeLocal = mgr.timeFromStr12Hrs(etimeLocal);
        }
      }

      mealAlertOption[1].counter = data!.meal_daily_count;
      mealAlertOption[2].time = stimeLocal;
      mealAlertOption[3].time = etimeLocal;
    }

    setState(() {});
  }

  // getNotificationStatus() async {
  //   isNotificationLoadStatus = true;
  //   updateNotificationLoading();
  //   bool? status = await manager.getNotification();
  //   isNotificationLoadStatus = false;
  //   mealAlertOption[0].value = status;
  //   updateNotificationLoading();
  //   setState(() {});
  // }

  // updateNotificationStatus(value) async {
  //   isNotificationLoadStatus = true;
  //   updateNotificationLoading();

  //   bool? status =
  //       await manager.getNotification(needUpdate: true, value: value);
  //   isNotificationLoadStatus = false;
  //   mealAlertOption[0].value = status;
  //   updateNotificationLoading();
  //   setState(() {});
  // }

  updateNotificationStatus(String value) async {
    bool? status = await manager.mealSetting(isNotificationValue: value);
    if (status == null || status == false) {
      //onlineItemOption[0].value = false;
    } else {
      //onlineItemOption[0].value = true;
    }
    setState(() {});
  }

  getplanList() {
    AllPlansApiManager().getAllPlans(onSuccess: (List<GetAllPlansModel> data) {
      planSettingOption = [];

      planSettingOption.add(SettingOption(title: "Active Plan", section: 2));
      data.forEach((element) {
        if (element.typeOfOperation == "meal") {
          planSettingOption.add(SettingOption(
              title: "Manage Subscription",
              section: 2,
              subscriptionSubPlans: element.subscriptionSubPlans));
        }
      });

      //   SettingOption(title: "Manage Subscription", section: 2),
      // data.forEach((element) {
      //   print(element.title);
      //   final title = element.title;
      //   var obj = SettingOption(
      //       title: title,
      //       section: 2,
      //       subscriptionSubPlans: element.subscriptionSubPlans);
      //   planSettingOption.add(obj);
      // });

      getData = true;

      setState(() {});
    }, onError: () {
      addWidgetRefresh();
    });
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
                  itemList: mealTypeOption,
                  onTap: (sectionIndex, rowIndex) {
                    switch (rowIndex) {
                      case 0:
                        Routes.pushSimpleRootNav(
                            context: context,
                            child: PickYourDientVarientView());

                        break;
                      case 1:
                        Routes.pushSimpleRootNav(
                            context: context, child: AllergiesFoodListView());

                        break;
                      case 2:
                        Routes.pushSimpleRootNav(
                            context: context, child: LikesFoodListView());
                        break;
                      case 3:
                        Routes.pushSimpleRootNav(
                            context: context, child: ServingMealPlanView());

                        break;
                      default:
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              // SectionRowListView(
              //     itemList: paymentMethod,
              //     onTap: (sectionIndex, rowIndex) {
              //       Routes.pushSimple(
              //           context: context, child: SavedCardListView());
              //     }),
              // const SizedBox(
              //   height: 20,
              // ),
              SectionRowListView(
                  itemList: mealAlertOption,
                  onSelectionBool: ((boolValue, p1, p2) {
                    mealAlertOption[p2].value = boolValue;
                    updateNotificationStatus(boolValue == true ? "1" : "0");
                    setState(() {});
                  }),
                  onTap: (sectionIndex, rowIndex) {
                    // Routes.pushSimple(
                    //     context: context, child: ActivePlanView());
                  }),
              /*  const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: planSettingOption,
                  onTap: (sectionIndex, rowIndex) {
                    if (planSettingOption[rowIndex].type ==
                        SettingType.refresh) {
                      addWidgetLoading();
                      getplanList();
                      return;
                    }
                    if (planSettingOption[rowIndex].type ==
                        SettingType.loading) {
                      return;
                    }
                    var t = planSettingOption[rowIndex].title.toString();

                    var d = t;
                    //.replaceAll("Plan", "");
                    d = d.trim();
                    var data = planSettingOption[rowIndex].subscriptionSubPlans;
                    if (rowIndex == 0) {
                      Routes.pushSimpleRootNav(
                          context: context, child: ActivePlanView());
                    } else {
                      Routes.pushSimpleRootNav(
                          context: context,
                          child: PlanMonthlyYearlyView(
                            title: d,
                            subscriptionSubPlans: data,
                          ));
                    }
                  }),
                  */
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: homeOption,
                  onTap: (sectionIndex, rowIndex) {
                    if (rowIndex == 0) {
                      Routes.pushSimpleAndReplaced(
                          context: Constant
                              .navigatorKey.currentState!.overlay!.context,
                          child: Routes.setScheduleScreen());
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
            ]),
      ),
    );
  }
}
