import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';

import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/utils/exportPackages.dart';

class DeleteAccountManager {
  Future<bool?> deleteAccountUser() async {
    var token = await LocalStore().getToken();

    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_DELETE_ACCOUNT;
    print(url);
    waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        await LocalStore().removeAll();
        Routes.gotoMainScreen();

        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          await LocalStore().removeAll();
          Routes.gotoMainScreen();
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }
}
