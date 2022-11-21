// ignore: file_names
import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import '../../utils/exportPackages.dart';
import 'package:intl/intl.dart';

class CalendarAlertView extends StatelessWidget {
  Function(DateTime)? onDateSelect;
  DateTime? intialDate;
  CalendarAlertView({Key? key, this.onDateSelect, required this.intialDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfDateRangePickerTheme(
            data: SfDateRangePickerThemeData(
              //brightness: Brightness.dark,

              backgroundColor: Colors.white,
              viewHeaderTextStyle: colorStyle(),
              cellTextStyle: colorStyle(),
              selectionTextStyle: const TextStyle(color: Colors.white),
              selectionColor: AppColor.buttonColor,
              todayHighlightColor: AppColor.buttonColor,
              todayTextStyle: TextStyle(
                color: AppColor.buttonColor,
              ),
              leadingCellTextStyle: colorStyle(),
              leadingDatesTextStyle: colorStyle(),
              weekendDatesTextStyle: colorStyle(),
              weekNumberTextStyle: colorStyle(),
              headerTextStyle: colorStyle(),
              activeDatesTextStyle: colorStyle(),
            ),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              initialDisplayDate: intialDate,
              initialSelectedDate: intialDate,
              selectionMode: DateRangePickerSelectionMode.single,
              showNavigationArrow: true,
              onSelectionChanged: (data) {
                print(data.value);

                onDateSelect!(data.value);
              },
              monthViewSettings: const DateRangePickerMonthViewSettings(
                dayFormat: 'EEE',
              ),
            )));
  }

//METHOD : - WhiteColorStyle
  TextStyle colorStyle() {
    return const TextStyle(color: Colors.black, fontSize: 12);
  }
}
