import 'dart:convert';
import 'package:daly_doc/core/apisUtils/httpUrls.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/allowLocation/allowLocation.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:http/http.dart' as http;

import '../../../../core/apisUtils/internetCheck.dart';
import '../../../../core/helpersUtil/validator.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../widgets/dialogs/CommonDialogs.dart';
import '../../otpVerify/otpVerifyScreen.dart';

class RegisterApis {
  userRegister(
      {required String mobileNumber,
      required name,
      required password,
      required confirmPassword}) async {
    if (name.toString().isEmpty) {
      showAlert("Enter Name");
      print("Enter Name");
      return;
    } else if (mobileNumber.toString().isEmpty) {
      showAlert("Enter Phone No.");
      print("Enter Phone No.");
      return;
    } else if (password.toString().isEmpty) {
      print("pass enter");
      showAlert("Enter Password");
      print("Enter Password");
      return;
    } else if (password.toString().length < 6) {
      showAlert("Password must be 6 digit.");
      print("Enter 6 Password");
      return;
    } else if (confirmPassword.toString().isEmpty) {
      print("pass enter");
      showAlert("Enter Confirm Password");
      print("Enter Confirm Password");
      return;
    } else if (confirmPassword.toString() != password.toString()) {
      showAlert("Enter Confirm Password Correctly.");
      print("Enter Confirm Password Correctly");
      return;
    }
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return;
    }
    waitDialog();

    try {
      var param = {
        "name": name,
        "phone_no": mobileNumber,
        "password": password,
        "confirm_password": confirmPassword
      };
      Response response =
          await post(Uri.parse(HttpUrls.WS_USERREGISTER), body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        showAlert(data['message'].toString());

        var otp = data['otp'].toString();
        var uid = data['user_id'].toString();
        await LocalStore().setotp(otp);
        await LocalStore().setuid(uid);
        Routes.pushSimple(
            context: LocalString.navigatorKey.currentState!.context,
            child: OtpVerifyScreen());
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

  resendOtp() async {
    waitDialog();
    var uid = await LocalStore().getuid();
    try {
      Response response = await get(
        Uri.parse(HttpUrls.WS_RESENDOTP + uid),
      );

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();

        var otp = data['otp'].toString();
        var uid = data['user_id'].toString();
        await LocalStore().setotp(otp);
        await LocalStore().setuid(uid);
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

  otpApi({
    required String otp,
  }) async {
    var uid = await LocalStore().getuid();
    var param = {"user_id": uid, "otp": otp};
    try {
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_OTPVERIFICATION,
          ),
          body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        Routes.pushSimple(
            context: LocalString.navigatorKey.currentState!.context,
            child: AllowLocationScreen());
        dismissWaitDialog();
        showAlert(data['message'].toString());
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
