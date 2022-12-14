import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/logoutApi.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/createNewBusiness.dart';
import 'package:daly_doc/pages/excercisePlan/excercisePlanScreen.dart';
import 'package:daly_doc/pages/paymentPages/savedCardListView.dart';
import 'package:daly_doc/pages/settingsScreen/controller/settingController.dart';
import 'package:daly_doc/pages/smartScheduleScreens/smartScheduleView.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/pages/wakeUptimeView/wakeupTimeView.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import 'package:provider/provider.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

import '../authScreens/authManager/api/businessApis.dart';
import '../authScreens/authManager/models/businessCatModel.dart';
import '../authScreens/authManager/models/userBusinesModel.dart';
import '../authScreens/createNewBusinessScreens/CongratsScreen.dart';
import '../changePassword/changePasswordView.dart';
import '../dailyDevotinalPlan/views/momentOfPrayerView.dart';
import '../subscriptionPlansScreen/activePlanView.dart';
import '../subscriptionPlansScreen/planMonthlyYearlyView.dart';
import '../userProfile/userProfile.dart';
import 'ApiManager/AllPlansApiManager.dart';
import 'components/sectionRowListView.dart';
import 'model/SettingOption.dart';
import 'model/allPlanMode.dart';

class SettingScreen extends StatefulWidget {
  String? red;
  SettingScreen({Key? key, this.red}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var businessId = "";
  UserBusinessModel? UserBusinessData;

  List<WeekDaysModel> weekDays = [];
  var email = '';
  var name = '';
  int? dataIndex = 0;

  bool getData = false;
  bool isBusinessActive = false;
  List<SettingOption> accountOption = [
    SettingOption(title: "My Profile", section: 0),
    SettingOption(title: "Wake Time", section: 0),
    SettingOption(
        title: "Time Format 24 Hour", section: 1, type: SettingType.toggle),
  ];

  List<SettingOption> paymentMethod = [
    SettingOption(title: "Payment Method", section: 4),
  ];
  List<SettingOption> activePlannOption = [
    SettingOption(title: "Active Plan", section: 1),
  ];

  // List<SettingOption> planOption = [
  //   SettingOption(title: "Meal Plan", section: 2),
  //   SettingOption(title: "Exercise Plan", section: 2),
  //   SettingOption(title: "Daily Devontional Plan", section: 2),
  //   SettingOption(title: "Business Pro", section: 2),
  // ];
  List<SettingOption> planOption = [
    SettingOption(
      title: "Loading..",
      section: 2,
      type: SettingType.loading,
    ),
  ];
  List<SettingOption> smartOption = [
    SettingOption(title: "Smart Scheduling", section: 3),
  ];
  List<SettingOption> businessOption = [
    SettingOption(
      title: "Create New Business ",
      section: 3,
      type: SettingType.loading,
    ),
  ];
  List<SettingOption> logoutOption = [
    SettingOption(
      title: "Logout",
      section: 4,
      type: SettingType.logout,
    ),
  ];
  @override
  void initState() {
    super.initState();
    Constant.settingProvider.businessOption = [];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setToggle12Hrs();
      var loginType = await LocalStore().getLoginType();
      if (loginType == "" || loginType == "manual") {
        accountOption.insert(
          1,
          SettingOption(title: "Change Password", section: 0),
        );
      }
      getplanList();
      await Constant.settingProvider.refreshList();
      setState(() {});

      // getActivePlan();
    });
  }

  setToggle12Hrs() async {
    var timeformat = await LocalStore().get_TimeFormatUser();
    for (var element in accountOption) {
      if (element.type == SettingType.toggle) {
        element.value = timeformat;
      }
    }
    Constant.HRS24FORMAT = timeformat;
    setState(() {});
    bool? value = await Constant.settingProvider.timeSetGet24Hrs(needGet: true);
    if (value != null) {
      Constant.HRS24FORMAT = value;
      for (var element in accountOption) {
        if (element.type == SettingType.toggle) {
          element.value = value;
        }
      }
      setState(() {});
    }
  }

  // getActivePlan() {
  //   AllPlansApiManager().getActivePlan(
  //       needLoader: false,
  //       onSuccess: (List<PlanInfoModel> list) {
  //         list.forEach(
  //           (element) {
  //             if ("business" == element.plan_operation) {
  //               isBusinessActive = true;
  //             }
  //           },
  //         );
  //         if (isBusinessActive) {
  //           Constant.settingProvider.businessOption
  //               .add(SettingOption(title: "Create New Business ", section: 3));
  //           addCreateBizWidgetLoading();
  //           getUserBusinessDetail();
  //         }
  //         setState(() {});
  //       });

  //   //getUserBusinessDetail();
  // }

  // getUserBusinessDetail() async {
  //   UserBusinessModel? tempResponse =
  //       await Constant.settingProvider.getUserBusinessDetail();
  //   if (tempResponse != null) {
  //     UserBusinessData = tempResponse;
  //     email = UserBusinessData!.businessEmail.toString();
  //     name = UserBusinessData!.businessName.toString();
  //     dataIndex = UserBusinessData!.userBusinessCategory!.id;
  //     weekDays = UserBusinessData!.timing!;
  //     businessId = UserBusinessData!.userId.toString();
  //     print("businessId${businessId}");

  //     Constant.settingProvider.businessOption[0].title = "Business Setting";
  //   } else {
  //     Constant.settingProvider.businessOption[0].title = "Create New Business ";
  //   }
  //   Constant.settingProvider.businessOption[0].type = SettingType.normal;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: LocalString.lblSettingNavTitle,
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: bodyDesign(),
        ),
      )),
    );
  }

  addWidgetRefresh() {
    planOption = [];
    planOption.add(SettingOption(
      title: "Tap to refresh",
      section: 2,
      type: SettingType.refresh,
    ));
    setState(() {});
  }

  addWidgetLoading() {
    planOption = [];
    planOption.add(SettingOption(
      title: "Loading..",
      section: 2,
      type: SettingType.loading,
    ));
    setState(() {});
  }

  addCreateBizWidgetRefresh() {
    Constant.settingProvider.businessOption[0].title = "Tap to refresh";
    Constant.settingProvider.businessOption[0].section = 3;
    Constant.settingProvider.businessOption[0].type = SettingType.refresh;

    setState(() {});
  }

  addCreateBizWidgetLoading() {
    Constant.settingProvider.businessOption[0].title = "Loading";
    Constant.settingProvider.businessOption[0].section = 3;
    Constant.settingProvider.businessOption[0].type = SettingType.loading;

    setState(() {});
  }

  getplanList() {
    AllPlansApiManager().getAllPlans(onSuccess: (List<GetAllPlansModel> data) {
      planOption = [];

      data.forEach((element) {
        print(element.typeOfOperation);
        final title = element.title;
        var obj = SettingOption(
            title: title,
            section: 2,
            subscriptionSubPlans: element.subscriptionSubPlans);
        planOption.add(obj);
      });

      getData = true;

      setState(() {});
    }, onError: () {
      addWidgetRefresh();
    });
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return
        // getData == false
        //     ? Center(
        //         child: Container(
        //             margin: EdgeInsets.all(10),
        //             child: Center(
        //               child: CircularProgressIndicator(
        //                 strokeWidth: 2,
        //                 color: Colors.black,
        //               ),
        //             )),
        //       )
        //     :
        SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: accountOption,
                  onSelectionBool: ((boolValue, p1, p2) async {
                    accountOption[p2].value = boolValue;
                    await LocalStore().set_TimeFormatUser(boolValue.toString());
                    Constant.HRS24FORMAT = boolValue;
                    setState(() {});
                    Constant.taskProvider.startTaskFetchFromDB();
                    await Constant.settingProvider.timeSetGet24Hrs(
                        needGet: false, value: boolValue ? "1" : "0");
                  }),
                  onTap: (sectionIndex, rowIndex) {
                    if (rowIndex == 0) {
                      Routes.pushSimple(
                          context: context, child: UserProfileViewScreen());
                    } else if (accountOption[rowIndex].title ==
                        "Change Password") {
                      Routes.pushSimple(
                          context: context, child: ChangePassswordView());
                    } else if (accountOption[rowIndex].title == "Wake Time") {
                      Routes.pushSimple(
                          context: context,
                          child: WakeUpTimeViewScreen(
                            fromSetting: true,
                          ));
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: paymentMethod,
                  onTap: (sectionIndex, rowIndex) {
                    Routes.pushSimple(
                        context: context, child: SavedCardListView());
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: activePlannOption,
                  onTap: (sectionIndex, rowIndex) {
                    Routes.pushSimple(
                        context: context, child: ActivePlanView());
                  }),
              const SizedBox(
                height: 20,
              ),

              SectionRowListView(
                  itemList: planOption,
                  onTap: (sectionIndex, rowIndex) {
                    if (planOption[rowIndex].type == SettingType.refresh) {
                      addWidgetLoading();
                      getplanList();
                      return;
                    }
                    if (planOption[rowIndex].type == SettingType.loading) {
                      return;
                    }
                    var t = planOption[rowIndex].title.toString();

                    var d = t;
                    //.replaceAll("Plan", "");
                    d = d.trim();
                    var data = planOption[rowIndex].subscriptionSubPlans;
                    if (data!.first.operationType == "meal") {
                      Routes.pushSimple(
                          context: context, child: IntroMealPlanView());
                    } else if (data.first.operationType == "devotional") {
                      Routes.pushSimple(
                          context: context, child: MomentOfPrayerView());
                    } else if (data.first.operationType == "exercise") {
                      Routes.gotoExerciseFlow(context: context);
                    } else {
                      Routes.pushSimple(
                          context: context,
                          child: PlanMonthlyYearlyView(
                            title: d,
                            subscriptionSubPlans: data,
                          ));
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              // SectionRowListView(
              //     itemList: smartOption,
              //     onTap: (sectionIndex, rowIndex) {
              //       Routes.pushSimple(
              //           context: context, child: SmartScheduleView());
              //     }),
              // const SizedBox(
              //   height: 20,
              // ),
              if (Constant.settingProvider.businessOption.length != 0)
                Consumer<SettingController>(builder: (context, object, child) {
                  return SectionRowListView(
                      itemList: Constant.settingProvider.businessOption,
                      onTap: (sectionIndex, rowIndex) async {
                        print(businessId);
                        if (Constant.settingProvider.businessOption[rowIndex]
                                .type ==
                            SettingType.loading) {
                          return;
                        }
                        Constant.settingProvider.tempResponse == null
                            ? Routes.pushSimple(
                                context: context,
                                child: CreateNewBusinessScreen())
                            : Routes.pushSimple(
                                context: context,
                                child: BusinessSettingView(
                                  UserBusinessData:
                                      Constant.settingProvider.tempResponse,
                                  weekDays: weekDays,
                                ));
                      });
                }),
              if (Constant.settingProvider.businessOption.length != 0)
                const SizedBox(
                  height: 20,
                ),
              SectionRowListView(
                  itemList: logoutOption,
                  onTap: (sectionIndex, rowIndex) async {
                    await LogoutApi().syncingBeforLogout();
                    print("SYNCED ALLL");
                    LogoutApi().logout();
                  })
            ]),
      ),
    );
  }
}
