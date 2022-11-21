import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/logoutApi.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/createNewBusiness.dart';
import 'package:daly_doc/pages/smartScheduleScreens/smartScheduleView.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

import '../changePassword/changePasswordView.dart';
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
  bool getData = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getplanList();
    });
  }

  List<SettingOption> accountOption = [
    SettingOption(title: "My Profile", section: 0),
    SettingOption(title: "Change Password", section: 0),
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
    SettingOption(title: "Create New Business ", section: 3),
  ];
  List<SettingOption> logoutOption = [
    SettingOption(
      title: "Logout",
      section: 4,
      type: SettingType.logout,
    ),
  ];
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

  getplanList() {
    AllPlansApiManager().getAllPlans(onSuccess: (List<GetAllPlansModel> data) {
      planOption = [];

      data.forEach((element) {
        print(element.title);
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
                  onTap: (sectionIndex, rowIndex) {
                    if (rowIndex == 0) {
                      Routes.pushSimple(
                          context: context, child: UserProfileViewScreen());
                    } else {
                      Routes.pushSimple(
                          context: context, child: ChangePassswordView());
                    }
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

                    Routes.pushSimple(
                        context: context,
                        child: PlanMonthlyYearlyView(
                          title: d,
                          subscriptionSubPlans: data,
                        ));
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: smartOption,
                  onTap: (sectionIndex, rowIndex) {
                    Routes.pushSimple(
                        context: context, child: SmartScheduleView());
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: businessOption,
                  onTap: (sectionIndex, rowIndex) {
                    Routes.pushSimple(
                        context: context, child: CreateNewBusinessScreen());
                  }),
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
