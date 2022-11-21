import 'dart:convert';

import 'package:daly_doc/core/Sql/DBIntializer.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/subtaskModel.dart';

class TaskModel {
  String email = "";
  int taskTimeStamp = 0;
  String howLong = "";
  String howOften = "";
  String note = "";
  String subNotes = "";
  String startTime = "";
  String endTime = "";
  String dateString = "";
  String isCompleted = "";
  int createTimeStamp = 0;
  int serverID = 0;
  int tid = 0;
  int id = 0;

  List<SubtaskModel>? subTaskslist = [];
  TaskModel(
      {this.email = "",
      this.taskTimeStamp = 0,
      this.endTime = "",
      this.dateString = "",
      this.startTime = "",
      this.subNotes = "",
      this.note = "",
      this.howOften = "",
      this.howLong = "",
      this.tid = 0,
      this.subTaskslist,
      this.createTimeStamp = 0,
      this.serverID = 0,
      this.isCompleted = "0",
      this.id = 0});
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    var subStr = json["subNotes"].toString();
    List<SubtaskModel>? subTaskslist = [];
    if (subStr != "") {
      print("subStr$subStr");
      var jsonSubTask = jsonDecode(subStr);
      var data = jsonSubTask as List;
      data.forEach(
        (element) {
          subTaskslist.add(SubtaskModel(
              description: element["description"].toString(),
              id: element["sId"],
              isCompleted:
                  element["isCompleted"].toString() == "1" ? true : false));
        },
      );
    }
    print("subTaskslist${subTaskslist.length}");
    return TaskModel(
        subTaskslist: subTaskslist,
        email: json["email"].toString(),
        howOften: json["howOften"].toString(),
        howLong: json["howLong"].toString(),
        note: json["note"].toString(),
        subNotes: json["subNotes"].toString(),
        startTime: json["startTime"].toString(),
        dateString: json["dateString"].toString(),
        endTime: json["endTime"].toString(),
        createTimeStamp: json["createTimeStamp"],
        tid: json["tId"],
        id: json["id"] == null ? 0 : json["id"],
        taskTimeStamp: json["taskTimeStamp"],
        isCompleted:
            json["isCompleted"] == null ? "0" : json["isCompleted"].toString());
  }
  int getCompleteTaskCount() {
    return subTaskslist!
        .where((element) => element.isCompleted == true)
        .toList()
        .length;
  }

  int getAllSubtaskCount() {
    return subTaskslist!.length;
  }

  Map<String, dynamic> toMap() {
    return {
      TASK_TABLE_KEY.ID: tid,
      TASK_TABLE_KEY.EMAIL: email,
      TASK_TABLE_KEY.TASK_TIME_STAMP: taskTimeStamp,
      TASK_TABLE_KEY.CREATE_TIME_STAMP: createTimeStamp,
      TASK_TABLE_KEY.HOW_LONG: howLong,
      TASK_TABLE_KEY.HOW_OFTEN: howOften,
      TASK_TABLE_KEY.SUBNOTESNOTE: subNotes,
      TASK_TABLE_KEY.NOTE: note,
      TASK_TABLE_KEY.STARTTIME: startTime,
      TASK_TABLE_KEY.ENDTIME: endTime,
      TASK_TABLE_KEY.DATETEXT: dateString,
      TASK_TABLE_KEY.ISCOMPELETED: isCompleted,
      TASK_TABLE_KEY.SERVERID: serverID,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      TASK_TABLE_KEY.EMAIL: email,
      TASK_TABLE_KEY.TASK_TIME_STAMP: taskTimeStamp,
      TASK_TABLE_KEY.CREATE_TIME_STAMP: createTimeStamp,
      TASK_TABLE_KEY.HOW_LONG: howLong,
      TASK_TABLE_KEY.HOW_OFTEN: howOften,
      TASK_TABLE_KEY.SUBNOTESNOTE: subNotes,
      TASK_TABLE_KEY.NOTE: note,
      TASK_TABLE_KEY.STARTTIME: startTime,
      TASK_TABLE_KEY.ENDTIME: endTime,
      TASK_TABLE_KEY.DATETEXT: dateString,
      TASK_TABLE_KEY.ISCOMPELETED: isCompleted,
      TASK_TABLE_KEY.SERVERID: serverID,
    };
  }
}
