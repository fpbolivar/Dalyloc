import 'dart:math';

import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';
import '../../../core/constant/constants.dart';
import '../../../core/localStore/localStore.dart';
import '../model/allPlanMode.dart';

class AllPlansApiManager {
  getAllPlans({required onSuccess, required onError}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      onError();

      return;
    }

    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    var url = HttpUrls.WS_GETALLPLANS;
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);

      var data = jsonDecode(response.body);
      // print('${data}');

      if (data['status'] == true) {
        var allPlans = data["allPlans"] as List;
        print("allPlans ${allPlans}");
        if (allPlans.length > 0) {
          List<GetAllPlansModel> plans =
              allPlans.map((e) => GetAllPlansModel.fromJson(e)).toList();
          print("tasks${plans.length}");
          onSuccess(plans);
        }
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
        }
        //  showAlert(data['message'].toString());
      }
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }

  planSubcribe(
      {required String planId, required String type, onSuccess}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }

    var header = {
      "Authorization": token,
    };

    int random(int min, int max) {
      return min + Random().nextInt(max - min);
    }

    int id = random(int.parse(planId) * 1212233, 99999999);

    var param = {
      "plan_id": planId,
      "type": type,
      "transaction_id": id.toString()
    };
    var url = HttpUrls.WS_SUBCRIBEPLANS;
    print(url);
    print(param);
    print(planId);
    waitDialog();
    try {
      Response response =
          await post(Uri.parse(url), headers: header, body: param);
      print(url);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');
      if (data["status"] == true) {
        showAlert("Congratulations, You subscribed to the plan.", onTap: () {
          Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
              .pop();
        });
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
        }
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }

  cancelPlan({required String planId, onSuccess}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }

    var header = {
      "Authorization": token,
    };

    var param = {
      "subscription_id": planId,
    };
    var url = HttpUrls.WS_CANCELPLANS;
    print(url);
    print(planId);
    try {
      Response response =
          await post(Uri.parse(url), headers: header, body: param);
      print(url);
      var data = jsonDecode(response.body);
      print('${data}');
      if (data["status_code"] == true) {
        showAlert(LocalString.msgCancelSubscription, onTap: () {
          Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
              .pop("true");
        });
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
        }
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }

  getActivePlan({onSuccess, needLoader = true}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      List<PlanInfoModel> temp = [];
      onSuccess(temp);
      return;
    }

    var header = {
      "Authorization": token,
    };

    var url = HttpUrls.WS_GETACTIVEPLANS;
    print(url);
    if (needLoader) {
      waitDialog();
    }
    try {
      Response response = await get(
        Uri.parse(url),
        headers: header,
      );
      if (needLoader) {
        dismissWaitDialog();
      }
      print(url);
      var data = jsonDecode(response.body);
      print('${data}');

      if (data["status_code"] == true) {
        var list = data["activeplans"] as List;
        if (list.length > 0) {
          List<PlanInfoModel> listPlan =
              list.map((obj) => PlanInfoModel.fromJson(obj)).toList();
          onSuccess(listPlan);
        } else {
          List<PlanInfoModel> temp = [];
          onSuccess(temp);
        }
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          List<PlanInfoModel> listPlan = [];
          onSuccess(listPlan);
          showAlert(data['message'].toString());
        }
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      if (needLoader) {
        dismissWaitDialog();
      }
      print(e.toString());
      showErrorAlert(e.toString());
      List<PlanInfoModel> temp = [];
      onSuccess(temp);
    }
  }
}
