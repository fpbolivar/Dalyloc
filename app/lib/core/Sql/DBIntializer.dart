import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBIntializer {
  static DBIntializer sharedInstance = DBIntializer();
  Database? _db;
  var TASKTABLE = "TASKTABLE";
  Future<Database> get db async {
    if (null != _db) {
      print("DB STATUS ${_db}");

      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    var path = await getPathDB();
    print("DB path ${path}");
    var db = await openDatabase(path,
        version: 5, onCreate: _onCreate, onUpgrade: _onUpgrade);

    // var db = await openDatabase(path,
    //   version: 4, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return db;
  }

  Future<String> getPathDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    const String DB_NAME = 'DalyDoc.db';
    String path = join(documentsDirectory.path, DB_NAME);
    return path;
  }

  Future<void> deleteDB() async {
    var path = await getPathDB();
    await deleteDatabase(path);
    return;
  }
  // void _updateTableCompanyV1toV2(Batch batch) {
  //   print("_updateTableCompanyV1toV2");

  //   batch.execute('ALTER TABLE $TASKTABLE ADD ${TASK_TABLE_KEY.TASKNAME} TEXT');
  // }

  _onUpgrade(Database db, oldVersion, newVersion) async {
    // createTaskTable(db);
    // return;
    print("oldVersion$oldVersion");
    var batch = db.batch();
    if (oldVersion == 1) {
      // We update existing table and create the new tables
      //_updateTableCompanyV1toV2(batch);
      batch.execute(
          'ALTER TABLE $TASKTABLE ADD ${TASK_TABLE_KEY.TASKNAME} TEXT');
    }
    if (oldVersion == 2) {
      // We update existing table and create the new tables
      //_updateTableCompanyV1toV2(batch);

      batch.execute(
          'ALTER TABLE $TASKTABLE ADD ${TASK_TABLE_KEY.UTCDATETIME} TEXT');
      batch.execute(
          'ALTER TABLE $TASKTABLE ADD ${TASK_TABLE_KEY.ISDELETED} TEXT');
    }
    if (oldVersion == 4) {
      batch.execute(
          'ALTER TABLE $TASKTABLE ADD ${TASK_TABLE_KEY.OPERATIONTYPE} TEXT');
    }

    await batch.commit();
  }

  _onCreate(Database db, int version) async {
    print("_onCreate");
    createTaskTable(db);
  }

  createTaskTable(Database db) async {
    print("DB Create ");
    // id INTEGER PRIMARY KEY AUTOINCREMENT,
    return await db.execute(
        "CREATE TABLE $TASKTABLE (${TASK_TABLE_KEY.ID} integer primary key,${TASK_TABLE_KEY.SERVERID} integer, ${TASK_TABLE_KEY.EMAIL} TEXT, ${TASK_TABLE_KEY.TASK_TIME_STAMP} integer, ${TASK_TABLE_KEY.CREATE_TIME_STAMP} integer, ${TASK_TABLE_KEY.HOW_LONG} TEXT, ${TASK_TABLE_KEY.HOW_OFTEN} TEXT,${TASK_TABLE_KEY.NOTE} TEXT,${TASK_TABLE_KEY.SUBNOTESNOTE} TEXT,${TASK_TABLE_KEY.DATETEXT} TEXT,${TASK_TABLE_KEY.ENDTIME} TEXT,${TASK_TABLE_KEY.STARTTIME} TEXT,${TASK_TABLE_KEY.ISCOMPELETED} TEXT, ${TASK_TABLE_KEY.TASKNAME} TEXT,  ${TASK_TABLE_KEY.UTCDATETIME} TEXT , ${TASK_TABLE_KEY.ISDELETED} TEXT,${TASK_TABLE_KEY.OPERATIONTYPE} TEXT)");
  }
}

class TASK_TABLE_KEY {
  static String ID = 'tId';
  static String EMAIL = 'email';

  static String TASK_TIME_STAMP = 'taskTimeStamp';
  static String CREATE_TIME_STAMP = ' createTimeStamp';
  static String HOW_LONG = 'howLong';
  static String HOW_OFTEN = 'howOften';
  static String NOTE = 'note';
  static String SUBNOTESNOTE = 'subNotes';
  static String STARTTIME = 'startTime';
  static String ENDTIME = 'endTime';
  static String DATETEXT = 'dateString';
  static String ISCOMPELETED = 'isCompleted';
  static String SERVERID = 'serverID';
  static String TASKNAME = 'taskName';
  static String UTCDATETIME = 'utcDateTime';
  static String ISDELETED = 'isDeleted';
  static String OPERATIONTYPE = 'operationType';
}
