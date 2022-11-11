import 'dart:io';
import 'package:daly_doc/core/apisUtils/httpUrls.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import '../../widgets/dialogs/CommonDialogs.dart';
import '../localStore/localStore.dart';
import 'internetCheck.dart';

class LoginApis extends ChangeNotifier {
  // getToken() async {
  //   String? token;
  //   // FirebaseMessaging.instance.getToken().then((String? token) async {
  //   //   assert(token != null);
  //   //   print("token" + token!);
  //   //   await LocalString().setFCMToken(token);
  //   // });

  //   await LocalString().setFCMToken(token!);
  // }

  googleFacebookLogin({accessToken = "", type = ""}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return;
    }
    //var device_id = await LocalString().getDeviceId();
    var fcmToken = await LocalStore().getFCMToken();

    var param = {
      'access_token': accessToken,
      'device_type': Platform.isIOS ? 'ios' : 'android',
      'device_token': "fcmToken",
      "login_type": type,
      "device_id": fcmToken == '' ? "No FCM TOKEN" : fcmToken,
    };
    print(jsonEncode(param));

    var url = type == "Facebook"
        ? HttpUrls.WS_FACEBOOKLOGIN
        : HttpUrls.WS_GOOGLELOGIN;
    print(url);
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return;
    }
    waitDialog();
    try {
      Response response = await post(Uri.parse(url), body: param);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var token = data["access_token"];
        var name = data["details"]['name'];
        var mobile = data["details"]['phone_no'];
        await LocalStore().set_MobileNumberOfUser(mobile.toString());
        await LocalStore().set_nameofuser(name.toString());
        await LocalStore().setToken(token.toString());
        Routes.pushSimpleAndReplaced(
            context: LocalString.navigatorKey.currentState!.overlay!.context,
            child: ScheduleCalendarScreen());
      } else {
        showAlert(data['message'].toString());
      }
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }
}
