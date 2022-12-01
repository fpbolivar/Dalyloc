import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userBusinesModel.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';

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
}
