import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/appoinmentPlan/views/lookingForView.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/logoutApi.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/createNewBusiness.dart';
import 'package:daly_doc/pages/appoinmentPlan/views/myAppointmentListView.dart';
import 'package:daly_doc/pages/authScreens/deleteAccount/deleteAccountView.dart';
import 'package:daly_doc/pages/changePassword/changePasswordView.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/views/momentOfPrayerView.dart';
import 'package:daly_doc/pages/settingsScreen/controller/settingController.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/pages/settingsScreen/model/allPlanMode.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/activePlanView.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/planMonthlyYearlyView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/createTaskView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/userProfile/userProfile.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/dashedLine/dashedView.dart';
import 'package:provider/provider.dart';

class DrawerItemModel {
  String? name;
  String? icon;
  bool? isLoader;
  DrawerItemModel({this.name = "", this.icon = "", this.isLoader = false});
}

class DalyDocDrawer extends StatelessWidget {
  List<DrawerItemModel> items = [
    DrawerItemModel(name: "Meal", icon: "assets/icons/fire.png"),
    DrawerItemModel(name: "Exercise", icon: "assets/icons/exercise.png"),
    DrawerItemModel(name: "Daily Devotional", icon: "assets/icons/prayer.png"),
    DrawerItemModel(name: "Business Pro", icon: "assets/icons/ic_taskEdit.png"),
    DrawerItemModel(
        name: "My Appointments", icon: "assets/icons/ic_taskEdit.png"),
    DrawerItemModel(
        name: "Manage Subscriptions", icon: "assets/icons/ic_calendar.png"),
    DrawerItemModel(
        name: "Change Password", icon: "assets/icons/ic_calendar.png"),
    DrawerItemModel(
        name: "Delete Account", icon: "assets/icons/ic_calendar.png"),
    DrawerItemModel(name: "Settings", icon: "assets/icons/ic_setting.png"),
    DrawerItemModel(name: "Logout", icon: "assets/icons/ic_calendar.png"),
  ];

  String userName = "";
  DalyDocDrawer({required this.userName});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: AppColor.newBgcolor,
      width: MediaQuery.of(context).size.width * 0.63,
      child: SingleChildScrollView(
          child: Container(
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userDetail(context),
                // SizedBox(
                //   height: 20,
                // ),
                //DashedLine(),
                Divider(
                  thickness: 2,
                ),
                // SizedBox(
                //   height: 10,
                // ),
                listView(),
                SizedBox(
                  height: 30,
                ),
              ]),
        ),
      )),
    );
  }

  Widget userDetail(context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Routes.pushSimple(
                    context: context, child: UserProfileViewScreen());
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: Image.asset("assets/icons/placeholderDalyDoc.png",
                        height: 60, width: 60),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColor.theme),
                      ),
                      Text(
                        "$userName",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: AppColor.halfGrayTextColor),
                      ),
                    ],
                  ),
                  Spacer(),
                  Center(child: Icon(Icons.keyboard_arrow_right)),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ]),
    );
  }

  Widget listView() {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () async {
                switch (items[index].name) {
                  case "Business Pro":
                    // waitDialog();
                    Constant.settingProvider.fromSidebar = true;

                    BizStatus? status =
                        await Constant.settingProvider.getBusinessIsActive();
                    // dismissWaitDialog();
                    // dismissWaitDialog();
                    // dismissWaitDialog();
                    if (status!.isActive! && status.isCreatedBusiness!) {
                      Routes.pushSimple(
                          context: context, child: BusinessSettingView());
                      return;
                    }
                    if (status.isActive! && !status.isCreatedBusiness!) {
                      Routes.pushSimple(
                          context: context, child: CreateNewBusinessScreen());
                      return;
                    }
                    if (!status.isActive! && !status.isCreatedBusiness!) {
                      await Constant.settingProvider.getAllplanList(
                          onSuccess: (SettingOption planOption) {
                            if (planOption.subscriptionSubPlans!.isNotEmpty) {
                              var t = planOption.title.toString();

                              var d = t;
                              //.replaceAll("Plan", "");
                              d = d.trim();
                              Routes.pushSimple(
                                  context: context,
                                  child: PlanMonthlyYearlyView(
                                    title: d,
                                    subscriptionSubPlans:
                                        planOption.subscriptionSubPlans!,
                                  ));
                            }
                          },
                          onError: (SettingOption planOption) {});

                      return;
                    }

                    break;
                  case "Create Task":
                    Routes.pushSimple(
                        context: context, child: CreateTaskView());

                    break;
                  case "Daily Devotional":
                    Routes.pushSimple(
                        context: context, child: MomentOfPrayerView());

                    break;
                  case "Meal":
                    Routes.pushSimple(
                        context: context, child: IntroMealPlanView());

                    break;
                  case "Exercise":
                    Routes.gotoExerciseFlow(context: context);

                    break;
                  case "Apointment":
                    Routes.pushSimple(
                        context: context, child: LookingForView());

                    break;
                  case "Settings":
                    Routes.pushSimple(context: context, child: SettingScreen());

                    break;
                  case "Manage Subscriptions":
                    Routes.pushSimple(
                        context: context, child: ActivePlanView());
                    break;
                  case "Change Password":
                    Routes.pushSimple(
                        context: context, child: ChangePassswordView());
                    break;
                  case "Delete Account":
                    Routes.pushSimple(
                        context: context, child: DeleteAccountView());

                    break;
                  case "My Appointments":
                    Routes.pushSimple(
                        context: context, child: MyApointmentListView());
                    break;
                  case "Logout":
                    showConfirmAlert("Are you sure you want to Logout?",
                        onTap: (() async {
                      await LogoutApi().syncingBeforLogout();
                      print("SYNCED ALLL");
                      LogoutApi().logout();
                    }));
                    break;
                  default:
                }
              },
              child: _item(context, index));
        },
        separatorBuilder: (BuildContext context, int index) {
          // ignore: prefer_const_constructors
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Divider(
              thickness: 0.5,
            ),
          );
        },
      ),
    );
  }

  Widget _item(BuildContext ctx, int index) {
    return Center(
      child: Container(
        height: 50,
        child: Row(
          children: [
            // SizedBox(
            //   width: 10,
            // ),
            // InkWell(
            //   onTap: () {},
            //   child: Image.asset(
            //     items[index].icon ?? "",
            //     width: 20,
            //     height: 20,
            //   ),
            // ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                items[index].name ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColor.textBlackColor),
              ),
            ),
            Consumer<SettingController>(builder: (context, object, child) {
              return Constant.settingProvider.isBusinessCheckingLoader &&
                      index == 3
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          SizedBox(width: 15, height: 15, child: loaderList()),
                    )
                  : Container();
            }),
          ],
        ),
      ),
    );
  }
}
