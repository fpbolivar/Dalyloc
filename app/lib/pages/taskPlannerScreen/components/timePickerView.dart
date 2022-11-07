import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class TimePickerViewTask extends StatelessWidget {
  TimePickerViewTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "When?",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColor.textBlackColor),
        ),
        Container(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              // var newTod = TimeOfDay.fromDateTime(newDateTime);
              // _updateTimeFunction(newTod);
            },
            use24hFormat: false,
            minuteInterval: 1,
          ),
        ),
        Row(
          children: [
            Spacer(),
            Text(
              "on ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: AppColor.textBlackColor),
            ),
            Text(
              "10/28/2022",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: AppColor.theme),
            ),
            Spacer(),
          ],
        )
      ],
    );
  }
}
