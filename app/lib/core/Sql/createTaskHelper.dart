import 'dart:convert';
import 'dart:ffi';

import 'package:daly_doc/core/Sql/DBIntializer.dart';
import 'package:daly_doc/core/constant/constants.dart';

import '../../pages/taskPlannerScreen/model/TaskModel.dart';

class CreateTaskHelper {
  static Future<int> createTask(TaskModel data) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    print("FOR SAVING${data.toMap()}");
    var status = await dbClient.insert(tableName, data.toMap());
    print("SAVE $status}");
    return status;
  }

  static Future<int> updateTask(TaskModel data) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    print("FOR UPDATE${data.toMap()}");
    var status = await dbClient.update(tableName, data.toUpdateMap());
    print("UPDATE $status}");
    return status;
  }

  static Future<int> makeTaskIsCompleted(String data, int tid) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    print("FOR UPDATING");
    // var status = await dbClient.insert(tableName, data.toMap());
    // print("SAVE $status}");
    // Update some record
    int count = await dbClient.rawUpdate(
        'UPDATE $tableName SET ${TASK_TABLE_KEY.ISCOMPELETED} = ? WHERE ${TASK_TABLE_KEY.ID} = ?',
        [data, tid]);
    return count;
  }

  static Future<int> taskDelete(int tid) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    print("FOR DELETING");

    int count = await dbClient.rawUpdate(
        'DELETE FROM  $tableName  WHERE ${TASK_TABLE_KEY.ID} = ?', [tid]);
    return count;
  }

  static Future<int> updateSubTaskTaskIsCompleted(
      String subTaskJson, int tid) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    print("FOR UPDATING SUBTASK");
    int count = await dbClient.rawUpdate(
        'UPDATE $tableName SET ${TASK_TABLE_KEY.SUBNOTESNOTE} = ? WHERE ${TASK_TABLE_KEY.ID} = ?',
        [subTaskJson, tid]);
    return count;
  }

  static Future<List<Map<String, dynamic>>> getAllTask() async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    var fieldName = TASK_TABLE_KEY.DATETEXT;
    List<Map<String, dynamic>> dataJson = await dbClient.rawQuery(
        'SELECT * FROM $tableName WHERE $fieldName =?',
        [Constant.selectedDateYYYYMMDD]);
    var jsonTemp = json.encode(dataJson);
    print(jsonTemp);

    return dataJson;
  }
}
