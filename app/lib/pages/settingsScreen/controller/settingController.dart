import 'package:daly_doc/core/apisUtils/internetCheck.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userBusinesModel.dart';
import 'package:daly_doc/pages/settingsScreen/ApiManager/AllPlansApiManager.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/pages/settingsScreen/model/allPlanMode.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

class BizStatus {
  bool? isActive;
  bool? isCreatedBusiness;
  BizStatus({isActive = false, isCreatedBusiness = false});
}

class SettingController with ChangeNotifier {
  BusinessApis manager = BusinessApis();
  UserBusinessModel? tempResponse;
  var fromSidebar = false;
  List<SettingOption> businessOption = [];
  bool isBusinessCheckingLoader = false;
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

  Future<BizStatus?> getBusinessIsActive() async {
    BizStatus obj = BizStatus();
    obj.isActive = false;
    obj.isCreatedBusiness = false;
    isBusinessCheckingLoader = true;
    notifyListeners();
    tempResponse = await manager.getUserBusinessDetail(needLoader: false);
    isBusinessCheckingLoader = false;
    notifyListeners();

    isBusinessCheckingLoader = true;
    notifyListeners();
    List<PlanInfoModel>? list = await manager.getActivePlan();
    print(" getActivePlan list${list}");
    isBusinessCheckingLoader = false;
    notifyListeners();
    list?.forEach(
      (element) {
        if ("business" == element.plan_operation) {
          obj.isActive = true;
        }
      },
    );

    if (obj.isActive!) {
      if (tempResponse != null) {
        obj.isCreatedBusiness = true;
      } else {
        obj.isCreatedBusiness = false;
      }

      notifyListeners();
    } else {
      businessOption = [];
    }
    notifyListeners();
    return obj;
  }

  getAllplanList({onSuccess, onError}) {
    isBusinessCheckingLoader = true;
    notifyListeners();
    SettingOption planOption =
        SettingOption(title: "", subscriptionSubPlans: []);
    AllPlansApiManager().getAllPlans(onSuccess: (List<GetAllPlansModel> data) {
      isBusinessCheckingLoader = false;
      notifyListeners();

      for (var i = 0; i < data.length; i++) {
        print(data[i].typeOfOperation);
        final title = data[i].title;
        if (data[i].typeOfOperation == "business") {
          planOption.title = title;
          planOption.subscriptionSubPlans = data[i].subscriptionSubPlans;

          break;
        }
      }
      onSuccess(planOption);
    }, onError: () {
      isBusinessCheckingLoader = false;
      notifyListeners();
      onError(planOption);
    });
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
