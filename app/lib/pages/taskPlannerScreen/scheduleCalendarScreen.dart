import 'package:daly_doc/pages/notificationScreen/notificationScreen.dart';

import 'package:daly_doc/pages/taskPlannerScreen/createTaskView.dart';

import '../../core/helpersUtil/dateHelper.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/headerCalendar/headerCalendarModel.dart';
import 'package:daly_doc/widgets/headerCalendar/headerCalendarWidget.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/exportPackages.dart';
import 'components/timelineView.dart';

class ScheduleCalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleCalendarScreenState();
}

class ScheduleCalendarScreenState extends State<ScheduleCalendarScreen> {
  final CalendarController _controller = CalendarController();
  List<HeaderCalendarDatesModal> headerDateModal = [];
  var dateTemp = 15;
  HeaderCalendarDatesModal? selectedDate;
  @override
  void initState() {
    var dateList = DateHelper().getDateOfMonth();
    headerDateModal =
        dateList.map((e) => HeaderCalendarDatesModal.fromDate(e)).toList();
    headerDateModal.removeRange(0, DateHelper().getCurrentDayDD() - 1);
    selectedDate = headerDateModal.first;
    super.initState();
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
            Routes.presentSimple(context: context, child: CreateTaskView());
          },
          child: const Icon(Icons.add)),
      body: SafeArea(child: bodyView()),
    );
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
              setState(() {});
            },
          ),
          Expanded(
              child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
            ),
            child: TimelineView(),
          )),
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
                const Expanded(
                  child: CalendarAlertView(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: CustomButton.regular(
                    title: "Jumo to day",
                  ),
                )
              ],
            ));
      },
    );
  }
}
