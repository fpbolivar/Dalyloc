import 'package:intl/intl.dart';

class HeaderCalendarDatesModal {
  DateTime? dateTime;
  String? dayFormat;
  String? monthFormat;
  String? yyyyFormat;
  String? day;
  HeaderCalendarDatesModal(
      {this.dateTime,
      this.dayFormat,
      this.day,
      this.monthFormat,
      this.yyyyFormat}) {}
  factory HeaderCalendarDatesModal.fromDate(DateTime dt) {
    final DateFormat formatterDD = DateFormat('dd');
    final String dayDD = formatterDD.format(dt);
    final DateFormat formatterEEE = DateFormat('EEE');
    final String dayEEE = formatterEEE.format(dt);
    final DateFormat formatterMMMM = DateFormat('MMMM');
    final String dayMMMM = formatterMMMM.format(dt);
    final DateFormat formatterYYYY = DateFormat('yyyy');
    final String dayYYYY = formatterYYYY.format(dt);
    return HeaderCalendarDatesModal(
        dateTime: dt,
        day: dayDD,
        dayFormat: dayEEE,
        monthFormat: dayMMMM,
        yyyyFormat: dayYYYY);
  }
}
