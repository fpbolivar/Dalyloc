// ignore: file_names
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import '../../utils/exportPackages.dart';

class CalendarAlertView extends StatelessWidget {
  const CalendarAlertView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfDateRangePickerTheme(
            data: SfDateRangePickerThemeData(
              //brightness: Brightness.dark,
              backgroundColor: Colors.black,
              viewHeaderTextStyle: whiteColorStyle(),
              cellTextStyle: whiteColorStyle(),
              selectionTextStyle: whiteColorStyle(),
              // todayHighlightColor: Colors.amber,
              // todayTextStyle: TextStyle(color: Colors.white),
              leadingCellTextStyle: whiteColorStyle(),
              leadingDatesTextStyle: whiteColorStyle(),
              weekendDatesTextStyle: whiteColorStyle(),
              weekNumberTextStyle: whiteColorStyle(),
              headerTextStyle: whiteColorStyle(),
              activeDatesTextStyle: whiteColorStyle(),
            ),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.single,
              showNavigationArrow: true,
              monthViewSettings: const DateRangePickerMonthViewSettings(
                dayFormat: 'EEE',
              ),
            )));
  }

//METHOD : - WhiteColorStyle
  TextStyle whiteColorStyle() {
    return const TextStyle(color: Colors.white);
  }
}
