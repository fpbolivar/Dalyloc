import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userBusinesModel.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import 'package:daly_doc/utils/exportPackages.dart';

class SettingController with ChangeNotifier {
  BusinessApis manager = BusinessApis();
  UserBusinessModel? tempResponse;
  List<SettingOption> businessOption = [
    SettingOption(title: "Create New Business ", section: 3),
  ];
  Future<UserBusinessModel?> getUserBusinessDetail() async {
    UserBusinessModel? temp = await manager.getUserBusinessDetail();
    tempResponse = temp;

    if (tempResponse != null) {
      businessOption[0].title = "Business Setting";
    } else {
      businessOption[0].title = "Create New Business ";
    }
    notifyListeners();
    return temp;
  }
}
