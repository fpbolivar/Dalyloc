import 'package:daly_doc/core/Sql/DBIntializer.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/appoinmentPlan/views/lookingForView.dart';
import 'package:daly_doc/pages/appoinmentPlan/views/myAppointmentListView.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/upcomingAppointmentListView.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/views/momentOfPrayerView.dart';
import 'package:daly_doc/pages/notificationScreen/notificationScreen.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/drawerView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/viewDetailTask.dart';

import 'package:daly_doc/pages/taskPlannerScreen/createTaskView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/ApisManager/Apis.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/AllTaskModel.dart';
import 'package:daly_doc/widgets/floatingActionButton/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../core/constant/constants.dart';
import '../../core/helpersUtil/dateHelper.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/headerCalendar/headerCalendarModel.dart';
import 'package:daly_doc/widgets/headerCalendar/headerCalendarWidget.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/exportPackages.dart';
import '../../widgets/syncingView/syncingView.dart';
import 'components/timelineView.dart';
import 'model/GroupTaskItemModel.dart';
import 'model/TaskModel.dart';

class ScheduleCalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleCalendarScreenState();
}

class ScheduleCalendarScreenState extends State<ScheduleCalendarScreen> {
  final CalendarController _controller = CalendarController();
  List<HeaderCalendarDatesModal> headerDateModal = [];
  var dateTemp = 15;
  HeaderCalendarDatesModal? selectedDate;
  List<GroupTaskItemModel> taskGroupData = [];
  TaskManager manager = TaskManager();
  DateTime calendarSelectedDate = DateTime.now();
  var extend = false;
  String wakeUpTime = "";
  @override
  void initState() {
    manager = Constant.taskProvider;
    headerDateList(calendarSelectedDate);
    super.initState();
    getWakeUpTime();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var timeformat = await LocalStore().get_TimeFormatUser();
      Constant.HRS24FORMAT = timeformat;
      Constant.selectedDateYYYYMMDD = selectedDate!.dateFormatYYYYMMDD ?? "";
      getTaskList();
    });
  }

  getWakeUpTime() async {
    wakeUpTime = await LocalStore().getWakeTime();
    if (wakeUpTime == '') {
      var finalWk = TaskManager().generateUtcTime(time: "06:00");
      await LocalStore().setWake(finalWk);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      key: _scaffoldKey,

      drawer: Consumer<TaskManager>(builder: (context, object, child) {
        return DalyDocDrawer(
          userName: Constant.taskProvider.userName,
        );
      }),

      // ignore: unnecessary_new

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: floatActionButton(),
        // child: FloatingActionButton(
        //     elevation: 0.0,
        //     backgroundColor: AppColor.theme,
        //     onPressed: () {
        //       Routes.presentSimple(
        //           context: context,
        //           child: CreateTaskView(
        //             isUpdate: false,
        //             date: selectedDate!.dateTime!,
        //           ));
        //     },
        //     child: const Icon(Icons.add)),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          bodyView(),
          Positioned(
            bottom: 0,
            right: 0,
            child: Consumer<TaskManager>(builder: (context, object, child) {
              return manager.isSyncing ? SyncingView() : Container();
            }),
          )
        ],
      )),
    );
  }

  headerDateList(date) {
    var dateList = DateHelper().getDateOfMonth(date);
    headerDateModal =
        dateList.map((e) => HeaderCalendarDatesModal.fromDate(e)).toList();
    headerDateModal.removeRange(0, DateHelper().getCurrentDayDD(date) - 1);
    selectedDate = headerDateModal.first;
    Constant.selectedDateYYYYMMDD = selectedDate!.dateFormatYYYYMMDD ?? "";
    setState(() {});
  }

  getTaskList() async {
    Constant.taskProvider.getUserName();
    manager.fetchAllTaskFromServer();
  }

  bodyView() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          HeaderCalendar(
            headerDateList: headerDateModal,
            selectedDate: selectedDate,
            onClickDrawer: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            onClickNotification: () {
              Routes.pushSimple(context: context, child: NotificationScreen());
            },
            onClickSetting: () {
              Routes.pushSimple(context: context, child: SettingScreen());
            },
            onClickCalendar: () {
              showCalendarModalSheet();
            },
            onSelection: (dateItem) {
              //_controller.selectedDate = dateItem.dateTime;
              _controller.displayDate = dateItem.dateTime;

              selectedDate = dateItem;
              print("--->${selectedDate!.dateFormatYYYYMMDD}");
              Constant.selectedDateYYYYMMDD =
                  selectedDate!.dateFormatYYYYMMDD ?? "";
              getTaskList();
              setState(() {});
            },
          ),
          Consumer<TaskManager>(builder: (context, object, child) {
            return Expanded(
                child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
              ),
              child: manager.taskGroupData.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Image.asset("assets/icons/ic_emptyTask.png"),
                    )
                  : TimelineView(
                      taskGroupData: manager.taskGroupData,
                      onSelectItem: (section, row) async {
                        TaskModel item =
                            manager.taskGroupData[section].task![row];

                        if (item.operationType == TaskType.exercise.rawValue) {
                          Routes.gotoExerciseFlow(context: context);
                          return;
                        }
                        if (item.operationType ==
                            TaskType.business_appointment.rawValue) {
                          Routes.pushSimpleRootNav(
                              context: context,
                              child: UpcomingApointmentListView());
                          return;
                        }
                        if (item.operationType ==
                            TaskType.user_appointment.rawValue) {
                          Routes.pushSimpleRootNav(
                              context: context, child: MyApointmentListView());
                          return;
                        }
                        if (item.operationType == TaskType.meal.rawValue) {
                          Routes.pushSimpleRootNav(
                              context: context, child: MyMealPlanView());
                          return;
                        }
                        if (item.operationType == TaskType.prayer.rawValue) {
                          Routes.pushSimpleRootNav(
                              context: context, child: MomentOfPrayerView());
                          return;
                        }
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              var data =
                                  manager.taskGroupData[section].task![row];

                              return ViewTaskDetail(item: data);
                            });
                      },
                      onMarkComplete: (section, row) async {
                        int id = manager.taskGroupData[section].task![row].tid;
                        String isCompleted = manager
                            .taskGroupData[section].task![row].isCompleted;
                        manager.taskGroupData[section].task![row].isCompleted =
                            isCompleted == "0" ? "1" : "0";
                        isCompleted = manager
                            .taskGroupData[section].task![row].isCompleted;
                        //   data.createTimeStamp =
                        DateTime.now().microsecondsSinceEpoch;
                        await manager.makeTaskIsCompleted(isCompleted, id);
                        setState(() {});
                      },
                    ),
            ));
          })
        ],
      ),
    );
  }
  ////METHOD : - Calendar Bottom Sheet

  showCalendarModalSheet() {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Container(
            color: Colors.transparent,
            height: 350,
            child: Column(
              children: [
                Expanded(
                  child: CalendarAlertView(
                    intialDate: calendarSelectedDate,
                    onDateSelect: (dt) {
                      calendarSelectedDate = dt;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: CustomButton.regular(
                    title: "Jump to day",
                    onTap: () {
                      Constant.selectedDateYYYYMMDD =
                          manager.dateParseyyyyMMdd(calendarSelectedDate);
                      headerDateList(calendarSelectedDate);

                      getTaskList();
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ));
      },
    );
  }

  Widget floatActionButton() {
    return SpeedDial(
      // animatedIcon: AnimatedIcons.menu_close,
      // animatedIconTheme: IconThemeData(size: 22.0),
      // / This is ignored if animatedIcon is non null
      // child: Text("open"),
      // activeChild: Text("close"),
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 5,
      mini: false,
      renderOverlay: true,

      //openCloseDial: isDialOpen,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      overlayOpacity: 0.5,
      overlayColor: Colors.black,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),

      useRotationAnimation: true,
      tooltip: 'Open Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      foregroundColor: Colors.white,
      backgroundColor: AppColor.theme,

      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,

      shape: const StadiumBorder(),
      // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      children: [
        SpeedDialChild(
            child: Image.asset("assets/icons/ic_calendar.png",
                width: 20, height: 20, color: AppColor.fabItemImageColor),
            backgroundColor: Colors.deepOrange,
            backgroundColorItem: AppColor.appointmentItemBgColor,
            foregroundColor: Colors.white,
            label: 'Appointment',
            onTap: () {
              // showAlert("Coming soon");
              Routes.pushSimple(context: context, child: LookingForView());
            }),
        SpeedDialChild(
            child: Image.asset("assets/icons/fire.png",
                width: 20, height: 20, color: AppColor.fabItemImageColor),
            backgroundColor: Colors.deepOrange,
            backgroundColorItem: AppColor.mealItemBgColor,
            foregroundColor: Colors.white,
            label: 'Meal Plan',
            onTap: () {
              Routes.pushSimple(context: context, child: IntroMealPlanView());
            }),
        SpeedDialChild(
            child: Image.asset("assets/icons/prayer.png",
                width: 20, height: 20, color: AppColor.fabItemImageColor),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            backgroundColorItem: AppColor.prayerItemBgColor,
            label: 'Prayer',
            onTap: () {
              Routes.pushSimple(context: context, child: MomentOfPrayerView());
            }),
        SpeedDialChild(
            child: Image.asset("assets/icons/ic_taskEdit.png",
                width: 20, height: 20, color: AppColor.fabItemImageColor),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            backgroundColorItem: AppColor.taskItemBgColor,
            label: 'Task',
            onTap: () {
              Routes.pushSimpleRootNav(
                  context: context,
                  child: CreateTaskView(
                    isUpdate: false,
                    date: selectedDate!.dateTime!,
                  ));
            }),
      ],
    );
  }
}
