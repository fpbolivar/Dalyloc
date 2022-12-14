import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userDataModel.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class UserDetailsApi {
  Future<UserDetailModel?> getUserData({needLoader = true}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    var token = await LocalStore().getToken();
    if (needLoader) {
      waitDialog();
    }

    var url = HttpUrls.WS_GETUSERDATA;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      if (needLoader) {
        dismissWaitDialog();
      }
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["data"];
        if (obj != null) {
          var userData = UserDetailModel.fromJson(obj);

          await LocalStore().set_nameofuser(userData.name ?? "");
          await LocalStore().set_MobileNumberOfUser(userData.mobile_no ?? "");
          await LocalStore().setAge(
              userData.age.toString() == "null" ? "" : userData.age.toString());
          await LocalStore().setHeightOfUser(userData.height ?? "");
          await LocalStore().setGenderOfUser(userData.gender ?? "");
          await LocalStore().setWeightOfUser(userData.weight ?? "");
          await LocalStore().setDOB(userData.dateOfBirth ?? "");
          await LocalStore().setLoginType(userData.login_type ?? "manual");

          return userData;
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
      if (needLoader) {
        dismissWaitDialog();
      }
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }
}
