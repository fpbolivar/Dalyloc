import '../../../../core/LocalString/localString.dart';
import '../../../../core/apisUtils/internetCheck.dart';
import '../../../../core/constant/constants.dart';
import '../../../../core/localStore/localStore.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../widgets/dialogs/CommonDialogs.dart';
import '../../model/TaskModel.dart';

class DeleteTaskApi {
  deleteTask({
    required String id,
  }) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();
    var token = await LocalStore().getToken();
    var header = {"Authorization": token, 'Content-Type': 'application/json'};

    try {
      Response response = await get(
          Uri.parse(
            HttpUrls.WS_DELETETASK + id,
          ),
          headers: header);

      var responceData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        dismissWaitDialog();

        var data = jsonDecode(response.body);
        print(data);
        showAlert(data['message']);
      } else {
        dismissWaitDialog();
        print(response.reasonPhrase);
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
    }
  }
}
