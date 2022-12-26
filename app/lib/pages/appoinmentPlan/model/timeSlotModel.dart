import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';

class TimeSlotItemModel {
  bool? isSelected;
  bool? isDisable;
  String? id;
  String? title;
  String? localTime;
  String? utcTime;
  TimeSlotItemModel({
    this.isSelected,
    this.title,
    this.isDisable,
    this.utcTime,
    this.localTime,
    this.id,
  });

  factory TimeSlotItemModel.fromJson(Map<String, dynamic> json, String date) {
    print("======${json}");
    var time = TaskManager().generateLocalTime(time: json["start"].toString());
    var timeTemp = time;
    if (!Constant.HRS24FORMAT) {
      time = TaskManager().timeFromStr12Hrs(time);
    }
    var isDisable = false;
    var currentDate = TaskManager().dateParseyyyyMMddHHMM(DateTime.now());
    var tagtime = timeTemp;
    print("currentDate$currentDate");
    print("tagtime$tagtime");
    DateTime dt1 = DateTime.parse(currentDate);
    DateTime dt2 = DateTime.parse("$date " + tagtime);
    if (dt2.isBefore(dt1)) {
      print("DT2 is before DT1 ${dt1}");
      isDisable = true;
    }
    if (json["is_booked"].toString() == "1") {
      isDisable = true;
    }
    return TimeSlotItemModel(
      isSelected: false,
      isDisable: isDisable,
      id: json["id"].toString(),
      utcTime: json["start"].toString(),
      localTime: time,
      title: json["start"].toString(),
    );
  }
}
