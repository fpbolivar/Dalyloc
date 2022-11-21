import 'dart:convert';

import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/core/Sql/createTaskHelper.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/GroupTaskItemModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/TaskModel.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/constants.dart';
import '../model/subtaskModel.dart';

class TaskManager with ChangeNotifier {
  List<GroupTaskItemModel> taskGroupData = [];
  saveTaskData(data, onSuccess) async {
    await CreateTaskHelper.createTask(data);
    Constant.taskProvider.startTaskFetchFromDB();
    onSuccess();
    ToastMessage.showSuccessMessage(msg: LocalString.msgCreatedTask);
  }

  updateTaskData(data, onSuccess) async {
    await CreateTaskHelper.updateTask(data);
    Constant.taskProvider.startTaskFetchFromDB();
    onSuccess();
    ToastMessage.showSuccessMessage(msg: LocalString.msgUpdateTask);
  }

  Future<int> makeTaskIsCompleted(String data, int tid) async {
    return await CreateTaskHelper.makeTaskIsCompleted(data, tid);
  }

  Future<int> taskDelete(int tid) async {
    return await CreateTaskHelper.taskDelete(tid);
  }

  startTaskFetchFromDB() async {
    List<TaskModel> list = await getAllTask();
    list.forEach(
      (element) {
        print(element.startTime);
      },
    );
    taskGroupData = convertGroupTaskByTime(list);
    notifyListeners();
  }

  Future<List<TaskModel>> getAllTask() async {
    var data = await CreateTaskHelper.getAllTask();
    List<TaskModel> list = [];
    list = data.map((e) => TaskModel.fromJson(e)).toList();
    return list;
  }

  List<GroupTaskItemModel> convertGroupTaskByTime(List<TaskModel> taskdata) {
    Set<int> hrs = Set<int>();

    taskdata.forEach((element) {
      var sTime = element.startTime;
      if (sTime != "") {
        var timeSplit = sTime.split(":");
        print(timeSplit);
        int value = int.tryParse(timeSplit[0]) ?? 0;
        hrs.add(value);
      }
    });
    print(hrs);
    List<GroupTaskItemModel> groupTask = [];
    hrs.forEach((element) {
      var strTime = "";
      if (element < 10) {
        strTime = "0$element:00 AM";
      } else {
        strTime = "$element:00 PM";
      }
      groupTask.add(GroupTaskItemModel(
        hr: element,
        time: strTime,
      ));
    });
    for (int i = 0; i < groupTask.length; i++) {
      // print("GRO ${groupTask[i].hr}");
      groupTask[i].task = [];
      for (int j = 0; j < taskdata.length; j++) {
        var taskTime = taskdata[j].startTime;
        var groupHr = groupTask[i].hr;
        //print("$taskTime $groupHr");
        if (taskTime.startsWith(groupHr.toString())) {
          groupTask[i].task!.add(taskdata[j]);
        }
      }
    }
    groupTask.sort((obj1, obj2) => obj1.hr.compareTo(obj2.hr));
    print(groupTask.length);
    return groupTask;
  }

  String dateParseMMddyyyy(DateTime date) {
    var _date = DateFormat('MM/dd/yyyy').format(date).toString();
    return _date;
  }

  String dateFromStr(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  String timeFromStr(date) {
    DateTime parseDate = new DateFormat("h:mm a").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  String dateParseyyyyMMdd(DateTime date) {
    var _date = DateFormat('yyyy-MM-dd').format(date).toString();
    return _date;
  }

  calculateTimeIntevals() {}
  List<Map<String, dynamic>> subtaskJSON(List<SubtaskModel> data) {
    List<Map<String, dynamic>> jsonArray = [];
    data.forEach((element) {
      jsonArray.add({
        "sId": element.id,
        "description": element.description,
        "isCompleted": element.isCompleted == false ? "0" : "1"
      });
    });
    return jsonArray;
  }

  completeMarkSubtaskTaskData(TaskModel task) async {
    final subtasks = subtaskJSON(task.subTaskslist!);
    final subtasksStr = json.encode(subtasks);
    await CreateTaskHelper.updateSubTaskTaskIsCompleted(subtasksStr, task.tid);
    Constant.taskProvider.notifyListeners();
  }
}
