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
  String isDeleted = "";
  String utcDateTime = "";
  String operationType = "";
  String user_id = "";

  String lat = "";
  String lng = "";
  String location = "";

  int createTimeStamp = 0;
  int serverID = 0;
  int tid = 0;
  String taskName = "";

  List<SubtaskModel>? subTaskslist = [];
  TaskModel(
      {this.location = "",
      this.lng = "",
      this.lat = "",
      this.email = "",
      this.taskTimeStamp = 0,
      this.operationType = "",
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
      this.taskName = "",
      this.isCompleted = "0",
      this.utcDateTime = "",
      this.isDeleted = "0"});
  factory TaskModel.fromServerJson(Map<String, dynamic> json) {
    var subStr = json["subNotes"].toString();
    List<SubtaskModel>? subTaskslist = [];
    if (subStr != "" && subStr != "null") {
      print("subStr$subStr");
      var jsonSubTask = jsonDecode(subStr);
      var data = jsonSubTask as List;
      data.forEach(
        (element) {
          subTaskslist.add(SubtaskModel(
              description: element["description"].toString(),
              id: element["s_id"],
              isCompleted:
                  element["is_completed"].toString() == "1" ? true : false));
        },
      );
    }
    print("subTaskslist${subTaskslist.length}");
    return TaskModel(
        subTaskslist: subTaskslist,
        email: json["email"].toString(),
        howOften: json["how_often"].toString(),
        howLong: json["how_long"].toString(),
        note: json["note"].toString(),
        subNotes: json["subNotes"].toString(),
        startTime: json["start_task_time"].toString(),
        dateString: json["date_format"].toString(),
        endTime: json["end_task_time"].toString(),
        operationType: json["task_type"] ?? "",
        location: json["location"] ?? "",
        lat: json["lat"] == null ? "" : json["lat"].toString(),
        lng: json["lng"] == null ? "" : json["lng"].toString(),
        createTimeStamp: json["create_time_stamp"] ?? 0,
        tid: json["t_id"] ?? 0,
        taskName: json["task_name"] ?? "",
        serverID: json["id"] ?? 0,
        utcDateTime: json["utc_date_time"] ?? "",
        isDeleted: json["isDeleted"] ?? "0",
        taskTimeStamp: json["task_time_stamp"] ?? 0,
        isCompleted: json["is_completed"] == null
            ? "0"
            : json["is_completed"].toString());
  }
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
        serverID: json["serverID"] ?? 0,
        createTimeStamp: json["createTimeStamp"],
        tid: json["tId"],
        operationType: json["operationType"] ?? "",
        taskTimeStamp: json["taskTimeStamp"],
        utcDateTime: json["utcDateTime"] ?? "",
        isDeleted: json["isDeleted"] ?? "0",
        taskName: json["taskName"] ?? "",
        location: json["location"] ?? "",
        lat: json["lat"] ?? "",
        lng: json["lng"] ?? "",
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
      TASK_TABLE_KEY.TASKNAME: taskName,
      TASK_TABLE_KEY.UTCDATETIME: utcDateTime,
      TASK_TABLE_KEY.ISDELETED: isDeleted,
      TASK_TABLE_KEY.OPERATIONTYPE: operationType,
      TASK_TABLE_KEY.location: location,
      TASK_TABLE_KEY.lat: lat,
      TASK_TABLE_KEY.lng: lng,
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
      TASK_TABLE_KEY.TASKNAME: taskName,
      TASK_TABLE_KEY.UTCDATETIME: utcDateTime,
      TASK_TABLE_KEY.ISDELETED: isDeleted,
      TASK_TABLE_KEY.OPERATIONTYPE: operationType,
      TASK_TABLE_KEY.location: location,
      TASK_TABLE_KEY.lat: lat,
      TASK_TABLE_KEY.lng: lng,
    };
  }
}

enum TaskType {
  meal,
  appointment,
  prayer,
  exercise,
  user_appointment,
  business_appointment
}

extension TopicExtension on TaskType {
  String get rawValue {
    switch (this) {
      case TaskType.user_appointment:
        return 'user_appointment';
      case TaskType.business_appointment:
        return 'business_appointment';
      case TaskType.meal:
        return 'meal';
      case TaskType.prayer:
        return 'prayer';
      case TaskType.appointment:
        return 'appointment';
      case TaskType.exercise:
        return 'exercise';
    }
  }
}
