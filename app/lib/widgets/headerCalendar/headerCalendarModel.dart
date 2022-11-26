import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:intl/intl.dart';

class HeaderCalendarDatesModal {
  DateTime? dateTime;
  String? dayFormat;
  String? monthFormat;
  String? monthShortFormat;
  String? yyyyFormat;
  String? day;
  String? dateFormatYYYYMMDD;
  HeaderCalendarDatesModal(
      {this.dateTime,
      this.dayFormat,
      this.day,
      this.dateFormatYYYYMMDD,
      this.monthFormat,
      this.monthShortFormat,
      this.yyyyFormat}) {}
  factory HeaderCalendarDatesModal.fromDate(DateTime dt) {
    final DateFormat formatterDD = DateFormat('dd');
    final String dayDD = formatterDD.format(dt);
    final DateFormat formatterEEE = DateFormat('EEE');
    final String dayEEE = formatterEEE.format(dt);
    final DateFormat formatterMMMM = DateFormat('MMMM');
    final String dayMMMM = formatterMMMM.format(dt);
    final DateFormat formatterMM = DateFormat('MMM');
    final String dayMM = formatterMM.format(dt);
    final DateFormat formatterYYYY = DateFormat('yyyy');
    final DateFormat formatterYYYYMMDD = DateFormat('yyyy');
    final String yyyymmdd = TaskManager().dateParseyyyyMMdd(dt);
    final String dayYYYY = formatterYYYY.format(dt);
    return HeaderCalendarDatesModal(
        dateTime: dt,
        day: dayDD,
        dayFormat: dayEEE,
        dateFormatYYYYMMDD: yyyymmdd,
        monthFormat: dayMMMM,
        monthShortFormat: dayMM,
        yyyyFormat: dayYYYY);
  }
}
