import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

class EditUserDataApi {
  EdituserData({
    String dob = "",
    String token = "",
    String name = "",
    String age = "",
    String feet = "",
    String inch = "",
    String weight = "",
    String gender = "",
  }) async {
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
      "height_feet": feet,
      "height_inch": inch,
      "weight": weight
    });
    request.headers.addAll(headers2);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dismissWaitDialog();
      showAlert("Profile is edited Successfully");

      List data = [];

      print(await response.stream.bytesToString());
    } else {
      dismissWaitDialog();
      print(response.reasonPhrase);
    }
  }
}
