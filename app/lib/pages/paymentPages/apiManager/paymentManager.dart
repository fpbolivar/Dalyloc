import 'dart:convert';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/paymentPages/addCardView.dart';
import 'package:daly_doc/pages/paymentPages/model/SavedCardModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

import '../../../../core/LocalString/localString.dart';
import '../../../../core/apisUtils/internetCheck.dart';

class PaymentManager {
  static var cardNeedRefresh = false;
  Future<bool?> addCard({cardNumber = "", cvv = "", expDate = ""}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_AddCard;
    var header = await HttpUrls.headerData();

    String date = TaskManager().dateParseyyyyMMdd(DateTime.now());
    var splitDate = expDate.toString().split("/");
    var expMonth = splitDate[0];
    var expYear = splitDate[1];
    var body = {
      "card_number": cardNumber,
      "exp_month": expMonth,
      "exp_year": expYear,
      "cvc": cvv
    };
    var request = json.encode(body);
    print(request);
    print(url);
    try {
      Response response =
          await post(Uri.parse(url), body: request, headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        cardNeedRefresh = true;
        return true;
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
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<bool?> setDefaultCard({cardID = ""}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_DefaultCardSet;
    var header = await HttpUrls.headerData();

    var body = {
      "card_id": cardID,
    };
    var request = json.encode(body);
    print(request);
    print(url);
    try {
      Response response =
          await post(Uri.parse(url), body: request, headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        return true;
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
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<bool?> deleteCard({cardID = ""}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_DeleteCard;
    var header = await HttpUrls.headerData();

    var body = {
      "card_id": cardID,
    };
    var request = json.encode(body);
    print(request);
    print(url);
    try {
      Response response =
          await post(Uri.parse(url), body: request, headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        return true;
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
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<List<SavedCardModel>?> getCard() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GetAllCard;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var itemList = data["cards"] as List;
        if (itemList.length > 0) {
          List<SavedCardModel> dataMenu =
              itemList.map((e) => SavedCardModel.fromJson(e)).toList();
          return dataMenu;
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
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
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

    var param = {
      "sub_plan_id": planId,
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
        } else if (data["response_code"] != null) {
          if (data["response_code"] == 404) {
            // showAlert(data['message'].toString());
            showConfirmAlert(data['message'].toString(), onTap: () {
              var cxt = Constant.navigatorKey.currentState!.overlay!.context;
              Routes.pushSimple(context: cxt, child: AddCardView());
            }, btnName: "Add Card");
          } else {
            showAlert(data['message'].toString());
          }
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
}
