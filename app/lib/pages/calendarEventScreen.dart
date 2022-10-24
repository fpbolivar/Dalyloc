import '../core/helpersUtil/dateHelper.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/headerCalendar/headerCalendarModel.dart';
import 'package:daly_doc/widgets/headerCalendar/headerCalendarWidget.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../utils/exportPackages.dart';
import '../widgets/appBar/CustomAppBar.dart';
import 'package:intl/intl.dart';

class CalendarEventScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<CalendarEventScreen> {
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
        backgroundColor: AppColor.bgcolor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              HeaderCalendar(
                headerDateList: headerDateModal,
                selectedDate: selectedDate,
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
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: SfCalendar(
                  showDatePickerButton: true,
                  cellBorderColor: Colors.grey[600],
                  headerHeight: 0,
                  viewHeaderHeight: 0,
                  backgroundColor: Colors.grey[800],
                  controller: _controller,
                  view: CalendarView.day,
                  timeSlotViewSettings: TimeSlotViewSettings(
                      timelineAppointmentHeight: 500,
                      timeRulerSize: 80,
                      //  timeFormat: _customTimeLabelText! + ' hh',
                      timeTextStyle: TextStyle(
                          color: AppColor.textWhiteColor,
                          fontWeight: FontWeight.w300)),
                  onViewChanged: (ViewChangedDetails viewChangedDetails) {
                    SchedulerBinding.instance.addPostFrameCallback((duration) {
                      setState(() {});
                    });
                  },
                ),
              )),
            ],
          ),
        ));
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
            height: MediaQuery.of(context).size.height * 0.4,
            child: CalendarAlertView());
      },
    );
  }
}
