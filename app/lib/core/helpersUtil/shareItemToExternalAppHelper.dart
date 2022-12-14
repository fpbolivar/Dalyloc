import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/TaskModel.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';

Future<void> shareTask(TaskModel task) async {
  var taskName = 'Name: ${task.taskName}';
  var email = '${task.email}';
  if (email != "" && email != "null") {
    email = "Email: ${email}";
  } else {
    email = "";
  }
  var duration = 'Duration: ${task.howLong}';
  var sTime = '${task.startTime}';

  var eTime = '${task.endTime}';

  var dateSplit = task.dateString.split("-");
  var yyyy = dateSplit[0];
  var mm = dateSplit[1];
  var dd = dateSplit[2];
  DateTime dateT = DateTime(
    int.tryParse(yyyy) ?? 0,
    int.tryParse(mm) ?? 0,
    int.tryParse(dd) ?? 0,
  );
  var date = TaskManager().dateParseMMMDDYYYY(dateT);
  var date_Time = 'Date/Time: ${date} ( ${sTime} to ${eTime})';
  var repeat = 'Repeat: ${task.howOften.capitalize()}';
  var location = '${task.location}';
  if (location != "" && location != "null") {
    location = "Location: ${location}";
  } else {
    location = "";
  }
  var subTask = "";
  task.subTaskslist!.forEach((elemet) {
    subTask = "$subTask • ${elemet.description}\n";
  });

  if (subTask != "" && subTask != "null") {
    subTask = "Sub-Task:" + "\n" + subTask;
  } else {
    subTask = "";
  }
  var notes = "Description: ${task.note}";

  var shareItemGenerate = "";
  shareItemGenerate = "$shareItemGenerate$taskName\n";
  if (email != "") {
    shareItemGenerate = "$shareItemGenerate$email\n";
  }
  shareItemGenerate = "$shareItemGenerate$duration\n";
  shareItemGenerate = "$shareItemGenerate$date_Time\n";
  shareItemGenerate = "$shareItemGenerate$repeat\n";
  if (subTask != "") {
    shareItemGenerate = "$shareItemGenerate$subTask";
  }
  if (location != "") {
    shareItemGenerate = "$shareItemGenerate$location\n";
  }
  shareItemGenerate = "$shareItemGenerate$notes\n";
  shareItemGenerate = "$shareItemGenerate\nShared via Daly Doc\n";

  await FlutterShare.share(
    title: 'DalyDoc Task',
    text: shareItemGenerate,
  );
}
