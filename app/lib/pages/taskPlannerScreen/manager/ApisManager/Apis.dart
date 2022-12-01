import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

import '../../../../core/LocalString/localString.dart';
import '../../../../core/apisUtils/internetCheck.dart';
import '../../../../core/constant/constants.dart';
import '../../../../core/localStore/localStore.dart';
import '../../../../core/routes/routes.dart';
import '../../model/TaskModel.dart';

class TaskApiManager {
  Future<void> CreateTaskData(
      {required TaskModel data,
      required List<Map<String, dynamic>> subTask,
      onSuccess,
      isSync = false}) async {
    if (await internetCheck() == false) {
      //showAlert(LocalString.internetNot);
      onSuccess(0);
      return;
    }
    if (isSync == false) {
      waitDialog();
    }
    var token = await LocalStore().getToken();
    var headers2 = {"Authorization": token, 'Content-Type': 'application/json'};
    bool isCom = data.isCompleted == "0" ? false : true;

    try {
      var params = json.encode({
        'tId': data.tid,
        "email": data.email,
        "taskTimeStamp": data.taskTimeStamp.toString(),
        "createTimeStamp": data.createTimeStamp,
        "howLong": data.howLong,
        "task_type": data.operationType,
        "howOften": data.howOften,
        "note": data.note,
        "taskName": data.taskName,
        "isCompleted": isCom,
        "subNotes": subTask,
        "dateString": data.dateString,
        "startTime": data.startTime,
        "utcDateTime": data.utcDateTime,
        "endTime": data.endTime
      });
      print(params);
      // request.headers.addAll(headers2);

      // http.StreamedResponse response = await request.send();
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_CREATETASK,
          ),
          body: params,
          headers: headers2);

      var responceData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (isSync == false) {
          dismissWaitDialog();
        }
        var data = jsonDecode(response.body);
        print(data);
        onSuccess(data["task_id"]);
        return;
        // showAlert(data['message']);
        //Navigator.pop(Constant.navigatorKey.currentState!.overlay!.context);
      } else {
        if (isSync == false) {
          dismissWaitDialog();
        }
        print(response.reasonPhrase);
        return;
      }
    } catch (e) {
      print(e.toString());
      if (isSync == false) {
        dismissWaitDialog();

        showErrorAlert(e.toString());
      }
      return;
    }
  }

  updateTaskApi(
      {required TaskModel data,
      required List<Map<String, dynamic>> subTask,
      onSuccess,
      isSync = false}) async {
    if (await internetCheck() == false) {
      if (isSync == false) {
        showAlert(LocalString.internetNot);
      }
      onSuccess(0);
      return;
    }
    if (isSync == false) {
      waitDialog();
    }
    var token = await LocalStore().getToken();
    var headers2 = {"Authorization": token, 'Content-Type': 'application/json'};
    bool isCom = data.isCompleted == "0" ? false : true;

    try {
      var params = json.encode({
        'tId': data.tid,
        "email": data.email,
        "taskTimeStamp": data.taskTimeStamp.toString(),
        "createTimeStamp": data.createTimeStamp,
        "howLong": data.howLong,
        "task_type": data.operationType,
        "howOften": data.howOften,
        "taskName": data.taskName,
        "note": data.note,
        "isCompleted": isCom,
        "subNotes": subTask,
        "dateString": data.dateString,
        "startTime": data.startTime,
        "endTime": data.endTime,
        "utcDateTime": data.utcDateTime,
      });
      print(params);
      final url = HttpUrls.WS_EDITTASK + data.serverID.toString();
      print(url);
      // request.headers.addAll(headers2);

      // http.StreamedResponse response = await request.send();
      Response response = await post(
          Uri.parse(
            url,
          ),
          body: params,
          headers: headers2);

      var responceData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (isSync == false) {
          dismissWaitDialog();
        }
        var data = jsonDecode(response.body);
        print(data);
        onSuccess(1);
        // showAlert(data['message']);
        //Navigator.pop(Constant.navigatorKey.currentState!.overlay!.context);
      } else {
        if (isSync == false) {
          dismissWaitDialog();
        }
        print(response.reasonPhrase);
      }
    } catch (e) {
      if (isSync == false) {
        dismissWaitDialog();

        showErrorAlert(e.toString());
      }
      print(e.toString());
    }
  }

  getAllTaskData({required String date, onSuccess}) async {
    if (await internetCheck() == false) {
      //showAlert(LocalString.internetNot);
      List<TaskModel> tasks = [];
      onSuccess(tasks);
      return;
    }

    //waitDialog();
    var token = await LocalStore().getToken();
    var headers2 = {"Authorization": token, 'Content-Type': 'application/json'};

    try {
      var params = json.encode({"dateString": date});
      print(params);
      var url = HttpUrls.WS_GETALLTASK + date;
      print(url);
      Response response = await get(
          Uri.parse(
            url,
          ),
          headers: headers2);

      var responceData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // dismissWaitDialog();

        var data = jsonDecode(response.body);
        print(data);
        if (data["status_code"] == true) {
          var allTask = data["allTask"] as List;
          if (allTask.length > 0) {
            List<TaskModel> tasks =
                allTask.map((e) => TaskModel.fromServerJson(e)).toList();

            onSuccess(tasks);
          } else {
            List<TaskModel> tasks = [];
            onSuccess(tasks);
          }
        } else {
          if (data["auth_code"] != null || token == null) {
            showAlert(LocalString.msgSessionExpired, onTap: () {
              Routes.gotoMainScreen();
            });
          }
        }
      } else {
        //dismissWaitDialog();
        print(response.reasonPhrase);
      }
    } catch (e) {
      //dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }

  Future<void> deleteTask({required String id, isSync = false}) async {
    if (await internetCheck() == false) {
      ///showAlert(LocalString.internetNot);

      return;
    }
    if (isSync == false) {
      waitDialog();
    }
    var token = await LocalStore().getToken();
    var header = {"Authorization": token, 'Content-Type': 'application/json'};
    var url = HttpUrls.WS_DELETETASK + id;
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);

      var responceData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (isSync == false) {
          dismissWaitDialog();
        }

        var data = jsonDecode(response.body);
        print(data);
        // showAlert(data['message']);
        return;
      } else {
        if (isSync == false) {
          dismissWaitDialog();
        }
        print(response.reasonPhrase);
        return;
      }
    } catch (e) {
      if (isSync == false) {
        dismissWaitDialog();
      }
      print(e.toString());
      //showErrorAlert(e.toString());
      return;
    }
  }

  Future<String?> getSetWakeUpTime({needUpdate = false, value = "0"}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    // waitDialog();

    var url = HttpUrls.WS_GET_SET_WAKEUP_TIME;
    if (needUpdate) {
      url = url + "?wake_up=$value";
    }
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      //dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["wake_up"];
        if (obj != null) {
          return obj.toString();
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      //dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }
}
