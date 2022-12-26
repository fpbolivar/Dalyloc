import 'dart:convert';

import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/core/Sql/DBIntializer.dart';
import 'package:daly_doc/core/Sql/createTaskHelper.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/main.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/ApisManager/Apis.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/AllTaskModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/GroupTaskItemModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/TaskModel.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';
import '../../../core/constant/constants.dart';
import '../model/subtaskModel.dart';

class TaskManager with ChangeNotifier {
  List<GroupTaskItemModel> taskGroupData = [];
  bool isSyncing = false;
  String userName = "";
  getUserName() async {
    userName = await LocalStore().get_nameofuser();
    notifyListeners();
  }

  fetchAllTaskFromServer() async {
    isSyncing = true;
    Constant.taskProvider.notifyListeners();
    Database db = await DBIntializer.sharedInstance.db;
    print("db statusss ${db.isOpen}");

    startTaskFetchFromDB();

    await deleteDataFromServer();

    TaskApiManager().getAllTaskData(
        date: Constant.selectedDateYYYYMMDD,
        onSuccess: (AllTaskModel allist) async {
          List<TaskModel> list = [];

          list.addAll(allist.alltask!);

          int value = await syncAllTask(list);
          print("FRESHER $value");
          startTaskFetchFromDB(dataPendingExercise: allist.pendingTask!);
          isSyncing = false;
          Constant.taskProvider.notifyListeners();
        });
    Future.delayed(Duration(seconds: 5), () async {});
  }

  saveTaskData(data, onSuccess, {needAlert = true}) async {
    TaskModel dataTemp = data;
    if (dataTemp.operationType == TaskType.exercise.rawValue) {
      return;
    }
    await CreateTaskHelper.createTask(data);
    Constant.taskProvider.startTaskFetchFromDB();
    // onSuccess();
    if (needAlert) {
      ToastMessage.showSuccessMessage(msg: LocalString.msgCreatedTask);
    }
    onSuccess();
  }

  updateTaskData(data, onSuccess, {needAlert = true}) async {
    TaskModel dataTemp = data;
    if (dataTemp.operationType == TaskType.exercise.rawValue) {
      return;
    }
    await CreateTaskHelper.updateTask(data);
    Constant.taskProvider.startTaskFetchFromDB();
    onSuccess();
    if (needAlert) {
      ToastMessage.showSuccessMessage(msg: LocalString.msgUpdateTask);
    }
  }

  Future<int> updateServerID(data) async {
    return await CreateTaskHelper.updateServerID(data);
  }

  Future<int> makeTaskIsCompleted(String data, int tid) async {
    return await CreateTaskHelper.makeTaskIsCompleted(data, tid);
  }

  Future<int> taskDelete(int tid) async {
    return await CreateTaskHelper.taskDelete(tid);
  }

  storeDeletedID(int tid) async {
    List<int> ids = [];
    String storedValue = await LocalStore().getDeletedIDS();
    if (storedValue == "") {
      ids.add(tid);
      String newList = json.encode(ids);
      await LocalStore().setIDSDeleted(newList);
    } else {
      var idsTemp = jsonDecode(storedValue);
      idsTemp.add(tid);
      String newList = json.encode(idsTemp);
      await LocalStore().setIDSDeleted(newList);
    }
  }

  Future<List<String>> getDeletedID() async {
    String storedValue = await LocalStore().getDeletedIDS();
    if (storedValue == "") {
      return [];
    } else {
      var idsTemp = jsonDecode(storedValue);
      var idsList = idsTemp as List;
      List<String> newList = [];
      idsList.forEach((element) {
        newList.add(element.toString());
      });
      return newList;
    }
  }

  Future<void> truncateTaskTable() async {
    return await CreateTaskHelper.truncate();
  }

  startTaskFetchFromDB({List<TaskModel>? dataPendingExercise}) async {
    var wakeUpTime = await LocalStore().getWakeTime();
    List<TaskModel> list = await getAllTask();
    list.forEach(
      (element) {
        print("element.operationType ${element.operationType}");
      },
    );
    taskGroupData = convertGroupTaskByTime(list);

    if (wakeUpTime != "") {
      var fullArray = wakeUpTime.split(":");
      final hr = int.tryParse(fullArray[0]) ?? 0;
      final min = int.tryParse(fullArray[1]) ?? 0;
      var wakeUPtime = wakeUpTime; //timeFromStr12Hrs(wakeUpTime);

      taskGroupData.insert(
          0,
          GroupTaskItemModel(
              hr: hr,
              time: wakeUPtime,
              task: [TaskModel(operationType: "wake")]));
    }

    bool isFormat24hr = await LocalStore().get_TimeFormatUser();
    if (!isFormat24hr) {
      taskGroupData.forEach((element) {
        if (element.time.trim().isNotEmpty) {
          element.time = timeFromStr12Hrs(element.time);
        }
        var allTask = element.task;
        allTask!.forEach((objTask) {
          if (objTask.startTime.trim().isNotEmpty) {
            objTask.startTime = timeFromStr12Hrs(objTask.startTime);
          }
          if (objTask.endTime.trim().isNotEmpty) {
            objTask.endTime = timeFromStr12Hrs(objTask.endTime);
          }
        });
      });
    }

    print("taskGroupData.length${taskGroupData.length}");
    if (dataPendingExercise != null) {
      var time = "06:00";
      if (Constant.HRS24FORMAT) {
        time = time;
      } else {
        time = timeFromStr12Hrs(time);
      }

      GroupTaskItemModel pendingExercise =
          GroupTaskItemModel(hr: 6, time: time, task: dataPendingExercise);
      if (taskGroupData.length > 0) {
        var found = false;
        for (int i = 0; i < taskGroupData.length; i++) {
          if (taskGroupData[i].hr == 6) {
            taskGroupData[i].task!.addAll(dataPendingExercise);
            found = true;
          }
        }
        if (!found) {
          taskGroupData.add(pendingExercise);
        }
      } else {
        taskGroupData.add(pendingExercise);
      }
    }
    notifyListeners();
  }

  Future<List<TaskModel>> getAllTask() async {
    var data = await CreateTaskHelper.getAllTask();
    List<TaskModel> list = [];
    list = data.map((e) => TaskModel.fromJson(e)).toList();
    return list;
  }

  Future<List<TaskModel>> getTaskByTID(id) async {
    var data = await CreateTaskHelper.getTaskByTID(id);
    List<TaskModel> list = [];
    list = data.map((e) => TaskModel.fromJson(e)).toList();
    return list;
  }

  Future<List<TaskModel>> getTaskServerID(id) async {
    var data = await CreateTaskHelper.getTaskByServerID(id);
    List<TaskModel> list = [];
    list = data.map((e) => TaskModel.fromJson(e)).toList();
    return list;
  }

  List<GroupTaskItemModel> convertGroupTaskByTime(List<TaskModel> taskdata) {
    for (int i = 0; i < taskdata.length; i++) {
      print(": taskdata[i].${taskdata[i].taskName}");
      print(": taskdata[i].startTime${taskdata[i].startTime}");
      print(": taskdata[i].endTime${taskdata[i].endTime}");
      if (taskdata[i].startTime.toString() != "null") {
        taskdata[i].startTime = generateLocalTime(time: taskdata[i].startTime);
      }
      if (taskdata[i].endTime.toString() != "null") {
        taskdata[i].endTime = generateLocalTime(time: taskdata[i].endTime);
      }

      // taskdata[i].endTime = generateLocalTime(time: taskdata[i].endTime);
    }

    Set<int> hrs = Set<int>();
    print("convertGroupTaskByTime ${taskdata.length}");
    taskdata.forEach((element) {
      var sTime = element.startTime;
      print("1) ###### ${element.startTime}");
      if (sTime != "") {
        var timeSplit = sTime.split(":");
        print(timeSplit);
        print("2) ###### ${timeSplit}");
        int value = int.tryParse(timeSplit[0]) ?? 0;
        hrs.add(value);
      }
    });
    print("###) hrs ${hrs}");
    List<GroupTaskItemModel> groupTask = [];
    hrs.forEach((element) {
      var strTime = element.toString();

      groupTask.add(GroupTaskItemModel(
        hr: element,
        time: "${strTime}:00",
      ));
    });
    for (int i = 0; i < groupTask.length; i++) {
      var groupHr = groupTask[i].hr;
      print("****ALLL **** . GROUP  $groupHr");
    }
    for (int i = 0; i < groupTask.length; i++) {
      // print("GRO ${groupTask[i].hr}");
      groupTask[i].task = [];

      for (int j = 0; j < taskdata.length; j++) {
        var taskTime = taskdata[j].startTime;
        print("1 <-->) ###### $taskTime");
        var groupHr = groupTask[i].hr;
        print("1 <- groupHr ->) ###### $groupHr");
        if (taskTime.startsWith("0")) {
          if (taskTime.length > 1) {
            if (taskTime[1] == "0") {
            } else {
              taskTime = taskTime.substring(1);
            }
          } else {
            taskTime = taskTime.substring(1);
          }
        }
        if (taskTime.startsWith(groupHr.toString())) {
          groupTask[i].task!.add(taskdata[j]);
        }
      }
    }
    groupTask.sort((obj1, obj2) => obj1.hr.compareTo(obj2.hr));
    groupTask.forEach((element) {
      print("1%%%%%%% ${element.hr}");
      print("2%%%%%%% ${element.time}");
    });
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

  DateTime dateObjFromStr(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());

    return inputDate;
  }

  String timeFromStr(date) {
    DateTime parseDate = new DateFormat("h:mm a").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  String generateUtcTime({time = ""}) {
    print("------>$time");

    final timeComponent = time.split(":");
    print("###$timeComponent");

    if (timeComponent.length > 0) {
      final hr = int.tryParse(timeComponent[0]) ?? 0;
      final min = int.tryParse(timeComponent[1]) ?? 0;
      var dd = DateTime.now();
      DateTime dateTime = DateTime(dd.year, dd.month, dd.day, hr, min);
      final utc = dateTime.toUtc();
      String formattedDate = DateFormat('HH:mm').format(utc);
      print("UTC TIME ${formattedDate}");
      return formattedDate;
    }

    return "";
  }

  String generateLocalTime({time = ""}) {
    print(time);

    final timeComponent = time.split(":");
    print(timeComponent);

    if (timeComponent.length > 0) {
      final hr = int.tryParse(timeComponent[0]) ?? 0;
      final min = int.tryParse(timeComponent[1]) ?? 0;
      var dd = DateTime.now();
      DateTime dateTime = DateTime.utc(dd.year, dd.month, dd.day, hr, min);

      //DateTime(dd.year, dd.month, dd.day, hr, min);
      final utc = dateTime.toLocal();
      String formattedDate = DateFormat('HH:mm').format(utc);
      print("LOCAL TIME ${formattedDate}");
      return formattedDate;
    }

    return "";
  }

  String yyyyMMdd_To_ddMMYYYY(date) {
    DateTime parseDate = new DateFormat("YYYY-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-YYYY');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  String yyyyMMdd_To_EEEMMMDDYYYY(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('EEE | MMM dd, yyyy');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  String yyyyMMdd_To_MMMDDYYYY(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd, yyyy');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  String timeFromStr12Hrs(date) {
    DateTime parseDate = new DateFormat("HH:mm").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  DateTime timeObjFromStr(date) {
    DateTime parseDate = new DateFormat("h:mm a").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return inputDate;
  }

  String convertTo24hrs(String date) {
    if (date.contains("AM") || date.contains("PM")) {
      DateTime parseDate = new DateFormat("h:mm a").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('HH:mm');
      var outputDate = outputFormat.format(inputDate);
      print(outputDate);
      return outputDate;
    } else {
      return date;
    }
  }

  String timeObj12to24Str(date, {indexAM = 0}) {
    var dateFinal = date;
    if (!Constant.HRS24FORMAT) {
      if (indexAM == 0) {
        dateFinal = dateFinal + " AM";
      } else {
        dateFinal = dateFinal + " PM";
      }
    }

    DateTime parseDate = new DateFormat("hh:mm a").parse(dateFinal);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  String dateParseyyyyMMddHHMM(DateTime date) {
    var _date = DateFormat('yyyy-MM-dd HH:mm').format(date).toString();
    return _date;
  }

  String timeFromDATE(DateTime date) {
    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(date);
    print(outputDate);
    return outputDate;
  }

  String dateParseyyyyMMdd(DateTime date) {
    var _date = DateFormat('yyyy-MM-dd').format(date).toString();
    return _date;
  }

  String dateParseMMMDDYYYY(DateTime date) {
    var _date = DateFormat('MMM dd, yyyy').format(date).toString();
    return _date;
  }

  String dateParseMMMddyyyy(DateTime date) {
    var _date = DateFormat('MMMM dd,yyyy').format(date).toString();
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

  List<Map<String, dynamic>> subtaskJSONMeal(List<MealItemModel> data) {
    List<Map<String, dynamic>> jsonArray = [];
    data.forEach((element) {
      jsonArray.add({
        "sId": element.id,
        "description": element.meal_name,
        "isCompleted": 0,
      });
    });
    return jsonArray;
  }

  String generateUtcDateTime({date = "", time = ""}) {
    print(date);
    print(time);
    final dateComponent = date.split("-");
    print(dateComponent);
    final timeComponent = time.split(":");
    print(timeComponent);
    if (dateComponent.length > 0) {
      final year = int.tryParse(dateComponent[0]) ?? 0;
      final month = int.tryParse(dateComponent[1]) ?? 0;
      final day = int.tryParse(dateComponent[2]) ?? 0;
      if (timeComponent.length > 0) {
        final hr = int.tryParse(timeComponent[0]) ?? 0;
        final min = int.tryParse(timeComponent[1]) ?? 0;
        DateTime dateTime = DateTime(year, month, day, hr, min);
        final utc = dateTime.toUtc();
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(utc);
        print("UTC DATE TIME ${formattedDate}");
        return formattedDate;
      }
    }
    return "";
  }

  completeMarkSubtaskTaskData(TaskModel task) async {
    final subtasks = subtaskJSON(task.subTaskslist!);
    final subtasksStr = json.encode(subtasks);
    await CreateTaskHelper.updateSubTaskTaskIsCompleted(subtasksStr, task.tid);
    Constant.taskProvider.notifyListeners();
  }

  Future<int> syncAllTask(List<TaskModel> data) async {
    await Future.forEach(data, (item) async {
      TaskModel itemTemp = item;
      if (itemTemp.subTaskslist!.length > 0) {
        final subtasks = subtaskJSON(itemTemp.subTaskslist!);
        final subtasksStr = json.encode(subtasks);
        itemTemp.subNotes = subtasksStr;
      } else {
        itemTemp.subNotes = "";
      }

      List<TaskModel> foundData = await getTaskByTID(item.tid);
      if (foundData.length > 0) {
        //update to db
        print("update to db ${foundData.first.taskName}");
        updateTaskViaSync(foundData.first, item);
      } else {
        saveTaskData(item, (status) {}, needAlert: false);
        //Insert To DB
      }
    });
    List<TaskModel> taskList = [];
    taskList = await getTaskServerID(0);
    await insertTaskViaSync(taskList, currentCount: 0);
    await deleteDataFromLocal(data);
    return 0;
  }

  updateTaskViaSync(TaskModel updateData, TaskModel serverObj) async {
    // if (updateData.operationType == TaskType.meal.rawValue) {
    //   return;
    // }
    //PUSH TO LOCAL
    if (updateData.createTimeStamp < serverObj.createTimeStamp) {
      updateTaskData(serverObj, (status) {}, needAlert: false);
      await updateServerID(serverObj);
    }
    //PUSH TO SERVER
    if (updateData.createTimeStamp > serverObj.createTimeStamp) {
      await updateServerID(serverObj);
      updateData.serverID = serverObj.serverID;
      final subtasks = subtaskJSON(updateData.subTaskslist!);

      TaskApiManager()
          .updateTaskApi(data: updateData, subTask: subtasks, isSync: true);
    }
  }

  Future<void> insertTaskViaSync(List<TaskModel> taskList,
      {currentCount = 0}) async {
    //PUSH TO SERVER
    if (currentCount < taskList.length) {
      int currentCountTemp = currentCount;
      TaskModel item = taskList[currentCountTemp];
      final subtasks = subtaskJSON(item.subTaskslist!);
      if (item.operationType == TaskType.exercise.rawValue) {
        return;
      }
      await TaskApiManager().CreateTaskData(
          data: item,
          subTask: subtasks,
          isSync: true,
          onSuccess: (value) async {
            item.serverID = value;
            await updateServerID(item);
            currentCountTemp++;
            insertTaskViaSync(taskList, currentCount: currentCountTemp);
          });
    } else {
      Constant.taskProvider.startTaskFetchFromDB();
      return;
    }
  }

  Future<void> deleteDataFromServer() async {
    List<String> ids = await getDeletedID();
    print("DELETED IDS$ids}");
    await Future.forEach(ids, (item) async {
      await TaskApiManager().deleteTask(id: item, isSync: true);
    });
    await LocalStore().setIDSDeleted("");
    return;
  }

  Future<void> deleteDataFromLocal(List<TaskModel> serverList) async {
    if (serverList.length == 0) {
      return;
    }
    List<TaskModel> localData = await getAllTask();
    List<TaskModel> keepLocalID = [];
    Set<int> removeLocalID = Set<int>();
    if (localData.length >= serverList.length) {
      await Future.forEach(localData, (itemL) async {
        await Future.forEach(serverList, (itemS) async {
          if (itemL.tid == itemS.tid && itemL.serverID != 0) {
            keepLocalID.add(itemL);
          }
          if (itemL.serverID == 0) {
            keepLocalID.add(itemL);
          }
        });
      });
    }
    if (localData.length < serverList.length) {
      await Future.forEach(serverList, (itemS) async {
        await Future.forEach(localData, (itemL) async {
          if (itemL.tid == itemS.tid && itemL.serverID != 0) {
            keepLocalID.add(itemL);
          }
          if (itemL.serverID == 0) {
            keepLocalID.add(itemL);
          }
        });
      });
    }

    await Future.forEach(keepLocalID, (Lid) async {
      localData.removeWhere((element) => element.tid == Lid.tid);
    });
    removeLocalID = localData.map((e) => e.tid).toList().toSet();

    print("removeLocalID$removeLocalID");
    await Future.forEach(removeLocalID, (tid) async {
      await taskDelete(tid);
    });
    return;
  }
}
