import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/logoutApi.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/createNewBusiness.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/paymentPages/savedCardListView.dart';
import 'package:daly_doc/pages/settingsScreen/ApiManager/AllPlansApiManager.dart';
import 'package:daly_doc/pages/settingsScreen/components/sectionRowListView.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/pages/settingsScreen/model/allPlanMode.dart';
import 'package:daly_doc/pages/smartScheduleScreens/smartScheduleView.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportScreens.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

import '../../../changePassword/changePasswordView.dart';
import '../../../subscriptionPlansScreen/activePlanView.dart';
import '../../../subscriptionPlansScreen/planMonthlyYearlyView.dart';
import '../../../userProfile/userProfile.dart';

class MealSettingView extends StatefulWidget {
  String? red;
  MealSettingView({Key? key, this.red}) : super(key: key);

  @override
  State<MealSettingView> createState() => _MealSettingViewState();
}

class _MealSettingViewState extends State<MealSettingView> {
  bool getData = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getplanList();
      getNotificationStatus();
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

  getNotificationStatus() async {
    isNotificationLoadStatus = true;
    updateNotificationLoading();
    bool? status = await manager.getNotification();
    isNotificationLoadStatus = false;
    mealAlertOption[0].value = status;
    updateNotificationLoading();
    setState(() {});
  }

  updateNotificationStatus(value) async {
    isNotificationLoadStatus = true;
    updateNotificationLoading();
    bool? status =
        await manager.getNotification(needUpdate: true, value: value);
    isNotificationLoadStatus = false;
    mealAlertOption[0].value = status;
    updateNotificationLoading();
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
              const SizedBox(
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
