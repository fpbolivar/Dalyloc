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
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    const String DB_NAME = 'DalyDoc.db';
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    createTaskTable(db);
  }

  createTaskTable(Database db) async {
    const String ID = 'id';
    const String EMAIL = 'email';
    const String DATE = 'date';
    const String TIME = 'time';
    const String TASK_TIME_STAMP = 'taskTimeStamp';
    const String CREATE_TIME_STAMP = ' createTimeStamp';
    const String HOW_LONG = 'howLong';
    const String HOW_OFTEN = 'howOften';
    const String NOTE = 'note';
    const String SUBNOTESNOTE = 'subNotes';
    return await db.execute(
        "CREATE TABLE $TASKTABLE ($ID integer primary key autoincrement, $EMAIL TEXT,$DATE TEXT, $TIME TEXT, $TASK_TIME_STAMP TEXT, $CREATE_TIME_STAMP TEXT, $HOW_LONG TEXT, $HOW_OFTEN TEXT,$NOTE TEXT,$SUBNOTESNOTE TEXT)");
  }
}
