import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class UserDetailsApi {
  Future<void> getUserData() async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    try {
      Response response = await get(Uri.parse(HttpUrls.WS_GETUSERDATA),
          headers: HttpUrls.headerData() as Map<String, String>);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        print(data["data"]);
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
