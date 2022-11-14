import 'package:daly_doc/pages/notificationScreen/notificationScreen.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/viewDetailTask.dart';

import 'package:daly_doc/pages/taskPlannerScreen/createTaskView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:provider/provider.dart';

import '../../core/constant/constants.dart';
import '../../core/helpersUtil/dateHelper.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/headerCalendar/headerCalendarModel.dart';
import 'package:daly_doc/widgets/headerCalendar/headerCalendarWidget.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/exportPackages.dart';
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
  @override
  void initState() {
    manager = Constant.taskProvider;
    headerDateList(calendarSelectedDate);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      // ignore: unnecessary_new
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: AppColor.theme,
          onPressed: () {
            Routes.presentSimple(
                context: context,
                child: CreateTaskView(
                  isUpdate: false,
                ));
          },
          child: const Icon(Icons.add)),
      body: SafeArea(child: bodyView()),
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
    manager.startTaskFetchFromDB();
    // print("list${list.length}");
  }

  bodyView() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          HeaderCalendar(
            headerDateList: headerDateModal,
            selectedDate: selectedDate,
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
                    title: "Jumo to day",
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
}
