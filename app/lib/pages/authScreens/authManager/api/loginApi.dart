import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';
import '../../../userProfile/userProfile.dart';

class LoginApi {
  void userLogin({required String mobileNumber, required password}) async {
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

    try {
      var param = {"phone_no": mobileNumber, "password": password};
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
        Routes.pushSimpleAndReplaced(
            context: LocalString.navigatorKey.currentState!.overlay!.context,
            child: ScheduleCalendarScreen());
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
