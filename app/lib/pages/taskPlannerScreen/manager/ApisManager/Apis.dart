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
  CreateTaskData({
    required TaskModel data,
    required List<Map<String, dynamic>> subTask,
  }) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();
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
        "howOften": data.howOften,
        "note": data.note,
        "isCompleted": isCom,
        "subNotes": subTask,
        "dateString": data.dateString,
        "startTime": data.startTime,
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
        dismissWaitDialog();

        var data = jsonDecode(response.body);
        print(data);
        showAlert(data['message']);
        Navigator.pop(Constant.navigatorKey.currentState!.overlay!.context);
      } else {
        dismissWaitDialog();
        print(response.reasonPhrase);
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }

  getAllTaskData({required String date}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();
    var token = await LocalStore().getToken();
    var headers2 = {"Authorization": token, 'Content-Type': 'application/json'};

    try {
      var params = json.encode({"dateString": date});
      print(params);

      Response response = await get(
          Uri.parse(
            HttpUrls.WS_GETALLTASK,
          ),
          headers: headers2);

      var responceData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        dismissWaitDialog();

        var data = jsonDecode(response.body);
        print(data);
        showAlert(data['message']);
        Navigator.pop(Constant.navigatorKey.currentState!.overlay!.context);
      } else {
        dismissWaitDialog();
        print(response.reasonPhrase);
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }

  deleteTask({
    required String id,
  }) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();
    var token = await LocalStore().getToken();
    var header = {"Authorization": token, 'Content-Type': 'application/json'};

    try {
      Response response = await get(
          Uri.parse(
            HttpUrls.WS_DELETETASK + id,
          ),
          headers: header);

      var responceData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        dismissWaitDialog();

        var data = jsonDecode(response.body);
        print(data);
        showAlert(data['message']);
      } else {
        dismissWaitDialog();
        print(response.reasonPhrase);
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }
}
