// import 'dart:async';
// import 'dart:io' as io;
// import 'package:flutter/cupertino.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'DBModel.dart';
// import '../Utility/utility.dart';
// import 'package:flutter/services.dart' show rootBundle;
 
// class DBHelper {

//   static DBHelper  sharedInstance   = DBHelper();
//   static Database _db;
//   static const String ID = 'id';
//   static const String NAME = 'photo_name';
//   static const String FILENAME = 'file_Name';
//   static const String DATECURRENT = 'date_Current';
//   static const String  FOLDERNAME= 'folderName';
//   static const String FOLDERID = 'folderID';
//   static const String FOLDER_COUNT = 'folderCount';
//   static const String TABLE = 'ScanTable';
//   static const String FOLDER_TABLE = 'FolderTable';
//   static const String DB_NAME = 'ScannerResult.db';
//   static const String SCANNED_RESULT = 'scannedResult';
  
 
//   Future<Database> get db async {
//     if (null != _db) {
//       return _db;
//     }
//     _db = await initDb();
//     return _db;
//   }
//   Future<Database> dbCheck() async {
//     if (null != _db) {
//       return _db;
//     }
//     _db = await initDb();
//     return _db;
//   }
//   initDb() async {
//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, DB_NAME);
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }
 

//   _onCreate(Database db, int version) async {
//       DBFolderModel objc1 = DBFolderModel(0,"Home","0");
//       DBFolderModel objc2 = DBFolderModel(0,"Invoices","0");
//       DBFolderModel objc3 = DBFolderModel(0,"Official","0");
//       DBFolderModel objc4 = DBFolderModel(0,"Others","0");
//     await db.execute("CREATE TABLE $TABLE ($ID integer primary key autoincrement, $NAME TEXT,$SCANNED_RESULT TEXT, $FILENAME TEXT, $DATECURRENT TEXT, $FOLDERNAME TEXT, $FOLDERID integer)");
    
//     await db.execute("CREATE TABLE $FOLDER_TABLE ($ID integer primary key autoincrement, $FOLDERNAME TEXT,$FOLDER_COUNT TEXT)");
     
     
     
  
//   //  await  DBHelper.sharedInstance.createNewFolder(objc1);

//   //  await DBHelper.sharedInstance.createNewFolder(objc2);
//   //  await DBHelper.sharedInstance.createNewFolder(objc3);
//   //  await  DBHelper.sharedInstance.createNewFolder(objc4);

  
//     //  DBHelper.sharedInstance.save(photo);

//     //defualFolderEntry();
//   }



//   defualFolderEntry(){
    
// var folderName = ["Home","Invoices","Official","Others"];


//  for (int i = 0; i < folderName.length; i++) {
        
    
       
//       DBFolderModel objc1 = DBFolderModel(0,folderName[i],"0");
//       DBHelper.sharedInstance.createNewFolder(objc1);

//       }
    
//   }
//   demoData(){
//      rootBundle.load('assets/Avatar.png').then((data) {
//      var imgString = Utility.base64String(data.buffer.asUint8List());

//  for (int i = 0; i < 1000; i++) {
        
    
       
//       DBModel photo = DBModel(0, "Kundan TESTER",imgString, "20/04/2020 06:44", "TestName","testFolder1",1);
//       DBHelper.sharedInstance.save(photo);

//       }
//     });
//   }
//   Future<DBModel> save(DBModel employee) async {
//     var dbClient = await db;
//     employee.id = await dbClient.insert(TABLE, employee.toMap());
//     return employee;
//   }



// Future<DBFolderModel> createNewFolder(DBFolderModel objc) async {
//     var dbClient = await db;
//     objc.id = await dbClient.insert(FOLDER_TABLE, objc.toMap());
//     return objc;
//   }
// Future<List<DBFolderModel>> getAllFolderList() async {
//     var dbClient = await db;
//     List<Map> maps = await dbClient.query(FOLDER_TABLE, columns: [ID, FOLDERNAME,FOLDER_COUNT]);

//     if(maps.length == 0){

//       await defualFolderEntry();
//       var dbClient = await db;
//     List<Map> maps = await dbClient.query(FOLDER_TABLE, columns: [ID, FOLDERNAME,FOLDER_COUNT]);
//      List<DBFolderModel> objc = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         objc.add(DBFolderModel.fromMap(maps[i]));
//       }
//     }
//     return objc;
//     }else{
//     List<DBFolderModel> objc = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         objc.add(DBFolderModel.fromMap(maps[i]));
//       }
//     }
    
//      return objc;

//     }
//   }
   
// Future<int> update(DBFolderModel objc) async {
//     var dbClient = await db;
//     return await dbClient.update(FOLDER_TABLE, objc.toMap(),
//         where: '$ID = ?', whereArgs: [objc.id]);
//   }
  
//   /*UPDATE Customers
// SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
// WHERE CustomerID = 1;
//   int count = await database.rawUpdate(
//     'UPDATE Test SET name = ?, value = ? WHERE name = ?',
//     ['updated name', '9876', 'some name']);*/
// // UPDATE table_name
// // SET column1 = value1, column2 = value2, ...
// // WHERE condition;
//  //SELECT * FROM members ORDER BY date_of_birth ASC
//   Future<List<DBModel>> getPhotos(id) async {
//     var dbClient = await db;
//     List<Map> maps = await dbClient.query(TABLE, columns: [ID, SCANNED_RESULT,NAME,FILENAME,DATECURRENT,FOLDERNAME,FOLDERID],where: '$FOLDERID = ?', whereArgs: [id]);

    
//     List<DBModel> employees = [];
//     if (maps.length > 0) {
//       for (int i = maps.length-1; i >= 0; i--) {
//         employees.add(DBModel.fromMap(maps[i]));
//       }
//     }
//     return employees;
//   }
// Future<List<DBModel>> searchData(text) async {
//     var dbClient = await db;
//     List<Map> maps = await dbClient.rawQuery('SELECT * FROM $TABLE WHERE $SCANNED_RESULT LIKE "%$text%";');
//     //query(TABLE, columns: [ID, SCANNED_RESULT,NAME,FILENAME,DATECURRENT,FOLDERNAME,FOLDERID]);

    
//     List<DBModel> employees = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         employees.add(DBModel.fromMap(maps[i]));
//       }
//     }
//     return employees;
//   }
// Future<int> deleteItem(int id) async {
//     var dbClient = await db;
//     return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  
//   }

//   Future<int> cleanDatabase() async {
//     var dbClient = await _db;
//    // dbClient.rawQuery('DELETE FROM $TABLE');
//     await dbClient.rawQuery("TRUNCATE TABLE $TABLE");
    
//     //dbClient.rawQuery('DROP DATABASE $TABLE');
    

//     //DELETE FROM employees;
//     // try{
      
//     //   await dbClient.transaction((txn) async {
//     //     var batch = txn.batch();
//     //     batch.delete(ID);
//     //     batch.delete(NAME);
//     //     await batch.commit();
//     //     return 1;
//     //   });
//     // } catch(error){
//     //   throw Exception('DbBase.cleanDatabase: ' + error.toString());
//     //   return 0;
//     // }
//   }
//   Future close() async {
//     var dbClient = await db;
//     dbClient.close();
//   }
// }