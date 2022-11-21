import 'dart:convert';
import 'dart:ffi';

import 'package:daly_doc/core/Sql/DBIntializer.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:sqflite/sqlite_api.dart';

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
    var status = await dbClient.update(tableName, data.toUpdateMap(),
        where: '${TASK_TABLE_KEY.ID} = ?', whereArgs: [data.tid]);
    print("UPDATE $status}");
    return status;
  }

  static Future<int> updateServerID(TaskModel data) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    print("FOR UPDATE SERVER ID${data.toMap()}");
    var status = await dbClient.update(
        tableName,
        {
          TASK_TABLE_KEY.SERVERID: data.serverID,
        },
        where: '${TASK_TABLE_KEY.ID} = ?',
        whereArgs: [data.tid]);
    print("UPDATE SERVER$status}");
    return status;
  }

  static Future<int> makeTaskIsCompleted(String data, int tid) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    print("FOR UPDATING");
    var createTimeStamp = DateTime.now().microsecondsSinceEpoch;
    var status = await dbClient.update(
        tableName,
        {
          TASK_TABLE_KEY.ISCOMPELETED: data,
          TASK_TABLE_KEY.CREATE_TIME_STAMP: createTimeStamp,
        },
        where: '${TASK_TABLE_KEY.ID} = ?',
        whereArgs: [tid]);
    // var status = await dbClient.insert(tableName, data.toMap());
    // print("SAVE $status}");
    // Update some record
    // int count = await dbClient.rawUpdate(
    //     'UPDATE $tableName SET ${TASK_TABLE_KEY.ISCOMPELETED} = ? WHERE ${TASK_TABLE_KEY.ID} = ?',
    //     [data, tid]);
    return status;
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

    var createTimeStamp = DateTime.now().microsecondsSinceEpoch;
    var status = await dbClient.update(
        tableName,
        {
          TASK_TABLE_KEY.SUBNOTESNOTE: subTaskJson,
          TASK_TABLE_KEY.CREATE_TIME_STAMP: createTimeStamp,
        },
        where: '${TASK_TABLE_KEY.ID} = ?',
        whereArgs: [tid]);

    // int count = await dbClient.rawUpdate(
    //     'UPDATE $tableName SET ${TASK_TABLE_KEY.SUBNOTESNOTE} = ? WHERE ${TASK_TABLE_KEY.ID} = ?',
    //     [subTaskJson, tid]);
    return status;
  }

  static Future<List<Map<String, dynamic>>> getAllTask() async {
    try {
      var dbClient = await DBIntializer.sharedInstance.db;
      var tableName = DBIntializer.sharedInstance.TASKTABLE;
      var fieldName = TASK_TABLE_KEY.DATETEXT;
      List<Map<String, dynamic>> dataJson = await dbClient.rawQuery(
          'SELECT * FROM $tableName WHERE $fieldName =?',
          [Constant.selectedDateYYYYMMDD]);
      var jsonTemp = json.encode(dataJson);
      print(jsonTemp);

      return dataJson;
    } on DatabaseException {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getTaskByTID(id) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    var fieldName = TASK_TABLE_KEY.ID;
    try {
      List<Map<String, dynamic>> dataJson = await dbClient
          .rawQuery('SELECT * FROM $tableName WHERE $fieldName =?', [id]);
      var jsonTemp = json.encode(dataJson);
      return dataJson;
    } on DatabaseException {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getTaskByServerID(id) async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    var fieldName = TASK_TABLE_KEY.SERVERID;
    try {
      List<Map<String, dynamic>> dataJson = await dbClient
          .rawQuery('SELECT * FROM $tableName WHERE $fieldName =?', [id]);
      var jsonTemp = json.encode(dataJson);

      return dataJson;
    } on DatabaseException {
      return [];
    }
  }

  static Future<void> truncate() async {
    var dbClient = await DBIntializer.sharedInstance.db;
    var tableName = DBIntializer.sharedInstance.TASKTABLE;
    try {
      final db = dbClient;
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(tableName);
        // batch.delete(CategoryNames.tableName);
        await batch.commit();
      });
      //await DBIntializer.sharedInstance.deleteDB();
    } catch (error) {
      print(error.toString());
      return;
    }
    return;
  }
}
