import 'dart:convert';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

import '../../../../core/LocalString/localString.dart';
import '../../../../core/apisUtils/internetCheck.dart';

class EditUserDataApi {
  EdituserData(
      {String dob = "",
      String token = "",
      String name = "",
      String age = "",
      String height = "",
      String inch = "",
      String weight = "",
      String gender = "",
      String email = "",
      String mobile = "",
      String countryCode = "",
      onSuccess}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();

    var headers2 = {"Authorization": token, 'Content-Type': 'application/json'};

    var request = http.Request('POST', Uri.parse(HttpUrls.WS_UPDATE_PROFILE));

    var paramss = {
      "name": name,
      "age": age,
      "date_of_birth": dob,
      "gender": gender,
      "height": height,
      "weight": weight,
      "email": email,
    };
    if (mobile != "") {
      paramss["phone_no"] = mobile;
    }
    if (countryCode != "") {
      paramss["country_code"] = countryCode;
    }
    request.body = json.encode(paramss);
    print(request.body);
    request.headers.addAll(headers2);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dismissWaitDialog();
      if (onSuccess != null) {
        onSuccess();
      } else {
        showAlert("Profile is updated Successfully");
      }
      await LocalStore().set_nameofuser(name);

      await LocalStore().set_Emailofuser(email);

      Constant.taskProvider.getUserName();
      List data = [];

      print(await response.stream.bytesToString());
    } else {
      dismissWaitDialog();
      print(response.reasonPhrase);
    }
  }

  sendOtpToVerifyPhoneNumber(
      {required String phoneNo,
      required String country_code,
      required onReceiveOTP}) async {
    try {
      if (await internetCheck() == false) {
        showAlert(LocalString.internetNot);

        return;
      }
      var token = await LocalStore().getToken();
      var header = {
        "Authorization": token,
        "content-type": 'application/json',
      };
      var param =
          json.encode({"phone_no": phoneNo, "country_code": country_code});
      print('${param}');
      waitDialog();
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_SENT_OTP_TO_UPDATENUMBER,
          ),
          body: param,
          headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        //showAlert(data['message'].toString());
        // Routes.pushSimple(
        //     context: Constant.navigatorKey.currentState!.context,
        //     child: CreateNewPasswordScreen(
        //       country_code: country_code,
        //     ));
        onReceiveOTP(data['otp'].toString(), data['user_id'].toString());
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

  otpVerifyApi(
      {required String otp,
      required String country_code,
      required uid,
      required onSuccess}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }

    var deviceToken = await LocalStore().getFCMToken();
    var param = {
      "user_id": uid,
      "otp": otp,
      "country_code": country_code,
      "device_token": deviceToken
    };

    print(param);
    print(
      HttpUrls.WS_OTPVERIFICATION,
    );
    waitDialog();
    try {
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_OTPVERIFICATION,
          ),
          body: param);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        //showAlert(data['message'].toString());
        onSuccess();
      } else {
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
