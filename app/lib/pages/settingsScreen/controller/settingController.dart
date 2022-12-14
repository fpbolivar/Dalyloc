import 'package:daly_doc/core/apisUtils/internetCheck.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userBusinesModel.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

class SettingController with ChangeNotifier {
  BusinessApis manager = BusinessApis();
  UserBusinessModel? tempResponse;
  List<SettingOption> businessOption = [];
  Future<UserBusinessModel?> getUserBusinessDetail() async {
    UserBusinessModel? temp =
        await manager.getUserBusinessDetail(needLoader: false);
    tempResponse = temp;

    if (tempResponse != null) {
      businessOption[0].title = "Business Setting";
    } else {
      businessOption[0].title = "Create New Business ";
    }
    notifyListeners();
    return temp;
  }

  Future<UserBusinessModel?> refreshList() async {
    businessOption.add(SettingOption(
        title: "Loading...", section: 3, type: SettingType.loading));
    List<PlanInfoModel>? list = await manager.getActivePlan();
    var isBusinessActive = false;

    tempResponse = await manager.getUserBusinessDetail(needLoader: false);
    list?.forEach(
      (element) {
        if ("business" == element.plan_operation) {
          isBusinessActive = true;
        }
      },
    );
    print("tempResponse$tempResponse");
    print("isBusinessActive$isBusinessActive");
    if (isBusinessActive) {
      if (tempResponse != null) {
        businessOption[0].title = "Business Setting";
      } else {
        businessOption[0].title = "Create New Business ";
      }
      businessOption[0].type = SettingType.normal;
      notifyListeners();
    } else {
      businessOption = [];
    }
    notifyListeners();
    return tempResponse;
  }

  Future<bool?> timeSetGet24Hrs({needGet = false, value = "0"}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    // waitDialog();

    var url = HttpUrls.WS_GET_UPDATE_24TIMEFORMAT;
    if (!needGet) {
      url = url + "?is24Format=$value";
    }
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      //dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["is24Format"];
        if (obj != null) {
          return obj.toString() == "1";
        }

        return false;
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
