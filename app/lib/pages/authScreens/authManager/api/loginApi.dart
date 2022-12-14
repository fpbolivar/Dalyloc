import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';
import '../../../userProfile/userProfile.dart';

class LoginApi {
  void userLogin(
      {required String mobileNumber, required password, required code}) async {
    print(mobileNumber);
    if (mobileNumber.toString().isEmpty) {
      showAlert("Enter Phone No.");
      print("Enter Phone No.");
      return;
    } else if (!Validator.isValidMobile(mobileNumber.toString())) {
      showAlert("Enter Valid Phone No.");
      print("Enter Valid Phone No.");
      return;
    } else if (password.toString().isEmpty) {
      print("pass enter");
      showAlert("Enter Password");
      print("Enter Password");
      return;
    }
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return;
    }
    waitDialog();
    var deviceToken = await LocalStore().getFCMToken();
    try {
      var param = {
        "phone_no": mobileNumber,
        "password": password,
        "country_code": code,
        "device_token": deviceToken
      };
      print(param);
      print(HttpUrls.WS_USERLOGIN);
      Response response =
          await post(Uri.parse(HttpUrls.WS_USERLOGIN), body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();

        showAlert(data['message'].toString());
        print("Bearer Token== ${data["access_token"]}");
        var token = data["access_token"];
        var name = data["details"]['name'];
        var mobile = data["details"]['phone_no'];
        LocalString.userMobileNo = mobile;
        LocalString.userName = name;
        await LocalStore().set_MobileNumberOfUser(mobile);
        await LocalStore().set_nameofuser(name);
        await LocalStore().setToken(token);
        await LocalStore().setLoginType(data["details"]['login_type']);
        Routes.pushSimpleAndReplaced(
            context: Constant.navigatorKey.currentState!.overlay!.context,
            child: Routes.setScheduleScreen());
      } else {
        dismissWaitDialog();
        showAlert(data['message'].toString());
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
