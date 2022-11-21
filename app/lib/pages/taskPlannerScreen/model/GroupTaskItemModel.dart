import 'package:daly_doc/pages/taskPlannerScreen/model/TaskModel.dart';

class GroupTaskItemModel {
  String time = "";
  int hr = 0;
  List<TaskModel>? task;
  GroupTaskItemModel({this.time = "", this.hr = 0, this.task});
}
