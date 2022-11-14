import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

import '../../../../core/localStore/localStore.dart';
import '../../../pagesGetStarted/introduction_animation_screen.dart';

class LogoutApi {
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
      waitDialog();
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
