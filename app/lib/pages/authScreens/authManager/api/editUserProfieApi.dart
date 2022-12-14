import 'dart:convert';
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
      onSuccess}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();

    var headers2 = {"Authorization": token, 'Content-Type': 'application/json'};

    var request = http.Request(
        'POST',
        Uri.parse(
            'https://codeoptimalsolutions.com/test/daly-doc/public/api/edit-profile'));
    request.body = json.encode({
      "name": name,
      "age": age,
      "date_of_birth": dob,
      "gender": gender,
      "height": height,
      "weight": weight
    });
    request.headers.addAll(headers2);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dismissWaitDialog();
      if (onSuccess != null) {
        onSuccess();
      } else {
        showAlert("Profile is updated Successfully");
      }

      List data = [];

      print(await response.stream.bytesToString());
    } else {
      dismissWaitDialog();
      print(response.reasonPhrase);
    }
  }
}
