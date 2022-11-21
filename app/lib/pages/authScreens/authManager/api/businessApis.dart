import 'dart:convert';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/businessCatModel.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

import '../../../../core/LocalString/localString.dart';
import '../../../../core/apisUtils/internetCheck.dart';

class BusinessApis {
  createBusiness({
    required String name,
    required image,
    required String lat,
    required String long,
    required String address,
    required String email,
    required String businessCategoryId,
  }) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();

    var headers2 = {"Authorization": token, 'Content-Type': 'application/json'};
    var url = HttpUrls.WS_CREATEBUSINESS;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'business_name': name,
      'business_email': email,
      'business_address': address,
      'lat': lat,
      'lng': long,
      'business_category_id': businessCategoryId
    });
    request.files
        .add(await http.MultipartFile.fromPath('business_image', image));
    request.headers.addAll(headers2);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  getBusinessCat(onSuccess) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      // "content-type": 'application/json',
    };
    try {
      Response response = await get(
          Uri.parse(HttpUrls.WS_GETALLBUSINESSCATGORY),
          headers: header);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        print(data["data"]);

        var allCat = data["data"] as List;
        if (allCat.length > 0) {
          List<BusinessCatModel> cat =
              allCat.map((e) => BusinessCatModel.fromJson(e)).toList();
          print("catagory ${cat.length}");
          onSuccess(cat);
        }
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
