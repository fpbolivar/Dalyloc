import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerCategoryModel.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerSettingModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

import '../../../core/LocalString/localString.dart';
import '../../../core/apisUtils/internetCheck.dart';
import '../../../core/localStore/localStore.dart';
import '../../../utils/exportPackages.dart';
import '../../../widgets/dialogs/CommonDialogs.dart';
import '../models/prayerModel.dart';

class PrayerApis {
  changePrayerStatus({id, status, onSuccess}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    print(token);
    var header = {
      "Authorization": token,
    };
    var param = {"id": id, "prayer_status": "answered"};
    try {
      // waitDialog();
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_CHANGEPRAYERSTATUS,
          ),
          headers: header,
          body: param);

      var data = jsonDecode(response.body);
      print('${data}');
      dismissWaitDialog();
      if (data['status'] == true) {
        dismissWaitDialog();
        onSuccess();
        // showAlert(data['message'].toString());
      } else {
        dismissWaitDialog();
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

      //showErrorAlert(e.toString());
    }
  }

  createPrayer({id, note, onSuccess}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();
    print(token);
    var header = {
      "Authorization": token,
    };
    DateTime date = DateTime.now();
    var timeStamp = date.microsecondsSinceEpoch;
    var dateStr = TaskManager().dateParseyyyyMMdd(date);
    var param = {
      "category_id": id,
      "prayer_note": note,
      "time_stamp": timeStamp.toString(),
      "current_date": dateStr
    };
    print(param);
    try {
      // waitDialog();
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_CREATEPRAYER,
          ),
          headers: header,
          body: param);

      var data = jsonDecode(response.body);
      print('${data}');
      dismissWaitDialog();
      if (data['status'] == true) {
        dismissWaitDialog();
        onSuccess();
        showAlert(data['message'].toString());
      } else {
        dismissWaitDialog();
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

      //showErrorAlert(e.toString());
    }
  }

  getAdmin(onSuccess) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    // waitDialog();
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    try {
      Response response =
          await get(Uri.parse(HttpUrls.WS_GETADMINPRAYER), headers: header);

      var data = json.decode(response.body);
      print('${data}');
      dismissWaitDialog();
      if (data['status'] == true) {
        print("result ${data["data"]}");
        var allCat = data["data"];
        print('${allCat}');
        AdminPrayerModel obj = AdminPrayerModel.fromJson(allCat);
        onSuccess(obj);

        //().businessAddress = allCat['business_address'];

        // if (allCat.length > 0) {
        //   List<AdminPrayerModel> rex =
        //       allCat.map((e) => AdminPrayerModel.fromJson(e)).toList();
        //   print("dataLength ${rex.length}");
        //
        // }
      } else {
        dismissWaitDialog();
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
        }
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());

      // showErrorAlert(e.toString());
    }
  }

  Future<List<PrayerCategoryModel>?> getPrayerCategory() async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    waitDialog();
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    try {
      Response response =
          await get(Uri.parse(HttpUrls.WS_PRAYER_CATEGORY), headers: header);

      var data = json.decode(response.body);
      print('${data}');
      dismissWaitDialog();
      if (data['status'] == true) {
        print("result ${data["data"]}");
        var allCat = data["data"] as List;
        return allCat.map((e) => PrayerCategoryModel.fromJson(e)).toList();
      } else {
        dismissWaitDialog();
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return null;
      // showErrorAlert(e.toString());
    }
  }

  getPRAYERLIST(onSuccess) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    try {
      Response response =
          await get(Uri.parse(HttpUrls.WS_GETPRAYERLIST), headers: header);

      var data = json.decode(response.body);
      print('${data}');
      dismissWaitDialog();
      if (data['status'] == true) {
        print("result ${data["data"]}");
        var allCat = data["data"] as List;
        print('${allCat}');

        // UserBusinessModel obj = UserBusinessModel.fromJson(allCat);

        //().businessAddress = allCat['business_address'];
        if (allCat.length > 0) {
          List<PrayerModel> rex =
              allCat.map((e) => PrayerModel.fromJson(e)).toList();
          print("dataLength ${rex.length}");
          onSuccess(rex);
        }
      } else {
        dismissWaitDialog();
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
        }
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());

      // showErrorAlert(e.toString());
    }
  }

  Future<bool?> prayerSetting(
      {isNotificationValue, paryer_daily_count, startTime, endTime}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_PRAYERSETTING;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      var param = {};
      if (startTime != null && startTime != "") {
        param["prayer_start_time"] = startTime;
      }
      if (endTime != null && endTime != "") {
        param["prayer_end_time"] = endTime;
      }
      if (paryer_daily_count != null) {
        param["paryer_daily_count"] = paryer_daily_count;
      }
      if (isNotificationValue != null) {
        param["prayer_notify"] = isNotificationValue;
      }
      print(param);
      Response response =
          await post(Uri.parse(url), body: json.encode(param), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        showAlert("Prayer setting has been updated.");
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

  Future<PrayerSettingModel?> getPrayerSetting() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GETPRAYERSETTING;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["data"];
        return PrayerSettingModel.fromJson(obj);
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
}
