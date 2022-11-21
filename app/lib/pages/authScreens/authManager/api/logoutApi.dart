import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/ApisManager/Apis.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/TaskModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

import '../../../../core/localStore/localStore.dart';
import '../../../pagesGetStarted/introduction_animation_screen.dart';

class LogoutApi {
  Future<void> syncingBeforLogout() async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return;
    }

    final manager = TaskManager();
    List<TaskModel> taskList = [];
    waitDialog(message: LocalString.msgSyncAndLogout);
    await manager.deleteDataFromServer();
    dismissWaitDialog();
    taskList = await manager.getTaskServerID(0);
    print("LOG 1");
    await manager.insertTaskViaSync(taskList, currentCount: 0);
    print("LOG 2");
    await manager.truncateTaskTable();
    print("LOG 3");
    return;
  }

  logout() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    print(token);
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };

    try {
      waitDialog(message: LocalString.msgSyncAndLogout);
      Response response = await get(
          Uri.parse(
            HttpUrls.WS_USERLOGOUT,
          ),
          headers: header);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        gotoMainScreen();
      } else {
        dismissWaitDialog();
        gotoMainScreen();
      }
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      gotoMainScreen();
      //showErrorAlert(e.toString());
    }
  }

  gotoMainScreen() async {
    await LocalStore().setToken("");
    Routes.pushSimpleAndReplaced(
        context: Constant.navigatorKey.currentState!.context,
        child: IntroductionAnimationScreen());
  }
}
