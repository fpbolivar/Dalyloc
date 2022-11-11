import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

class ChangePasswordApi {
  ChangePassword({
    required String oldPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (oldPassword.toString().isEmpty) {
      print("pass enter");
      showAlert("Enter Password");
      print("Enter Password");
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

    var param = {
      "old_password": oldPassword,
      "new_password": password,
      "confirm_password": passwordConfirmation
    };
    try {
      waitDialog();
      Response response = await post(
          Uri.parse(
            HttpUrls.WS_CHANGEPASSWORD,
          ),
          body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        Routes.pushSimple(
            context: LocalString.navigatorKey.currentState!.context,
            child: ScheduleCalendarScreen());
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
