import 'package:daly_doc/core/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import '../../../../core/localStore/localStore.dart';
import '../../../../utils/exportWidgets.dart';
import '../../../smartScheduleScreens/smartScheduleView.dart';

class ForgotPasswordApi {
  Future<void> forgotPassword(String phone_no) async {
    var param = {
      "phone_no": phone_no,
    };
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();
    try {
      Response response =
          await post(Uri.parse(HttpUrls.WS_FORGOTPASSWORD), body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        print(data["otp"]);

        var otp = data['otp'].toString();

        await LocalStore().setotp(otp);

        Routes.pushSimple(
            context: Constant.navigatorKey.currentState!.overlay!.context,
            child: OtpVerifyScreen(
              forgotPassword: true,
            ));
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
    var number = await LocalStore().get_MobileNumberOfUser();

    var param = {"phone_no": number};
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    try {
      waitDialog();
      Response response =
          await post(Uri.parse(HttpUrls.WS_RESENDOTPFORGOT), body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();

        var otp = data['otp'].toString();

        await LocalStore().setotp(otp);
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
    var number = await LocalStore().get_MobileNumberOfUser();
    var param = {"phone_no": number, "otp": otp};
    try {
      if (await internetCheck() == false) {
        showAlert(LocalString.internetNot);

        return;
      }
      waitDialog();
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_OTPVERIFICATIONFORGOT,
          ),
          body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        showAlert(data['message'].toString());
        Routes.pushSimple(
            context: Constant.navigatorKey.currentState!.context,
            child: CreateNewPasswordScreen());
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

  createPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    if (password.toString().isEmpty) {
      print("pass enter");
      showAlert("Enter Password");
      print("Enter Password");
      return;
    } else if (password.toString().length < 6) {
      showAlert("Password must be 6 digit.");
      print("Enter 6 Password");
      return;
    } else if (passwordConfirmation.toString().isEmpty) {
      print("pass enter");
      showAlert("Enter Confirm Password");
      print("Enter Confirm Password");
      return;
    } else if (passwordConfirmation.toString() != password.toString()) {
      showAlert("Enter Confirm Password Correctly.");
      print("Enter Confirm Password Correctly");
      return;
    }
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    var number = await LocalStore().get_MobileNumberOfUser();
    var param = {
      "phone_no": number,
      "password": password,
      "password_confirmation": passwordConfirmation
    };
    try {
      waitDialog();
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_CREATENEWPASSWORDAFTERFORGOT,
          ),
          body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        showAlert(
          data['message'].toString(),
          // onTap: () {
          //   Routes.pushSimple(
          //       context: Constant.navigatorKey.currentState!.context,
          //       child: LoginScreen());
          // },
        );
        Routes.pushSimple(
            context: Constant.navigatorKey.currentState!.context,
            child: LoginScreen());
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
