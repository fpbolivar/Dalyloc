import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerCategoryModel.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerSettingModel.dart';
import 'package:daly_doc/pages/excercisePlan/model/levelWorkOutModel.dart';
import 'package:daly_doc/pages/excercisePlan/model/workoutDataModel.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

import '../../../core/LocalString/localString.dart';
import '../../../core/apisUtils/internetCheck.dart';
import '../../../core/localStore/localStore.dart';
import '../../../utils/exportPackages.dart';
import '../../../widgets/dialogs/CommonDialogs.dart';
import '../model/exerciseDataModel.dart';

class ExerciseAPI {
  Future<List<LevelWorkoutModel>?> getPhysicalLevel() async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    // waitDialog();
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    try {
      Response response =
          await get(Uri.parse(HttpUrls.WS_GET_PHYSICAL_LEVEL), headers: header);

      var data = json.decode(response.body);
      print('${data}');
      dismissWaitDialog();
      if (data['status'] == true) {
        var allLevel = data["data"] as List;
        print('${allLevel}');
        List<LevelWorkoutModel> levels =
            allLevel.map((e) => LevelWorkoutModel.fromJson(e)).toList();
        return levels;
      } else {
        dismissWaitDialog();
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return null;
    }
  }

  Future<WorkoutReponseModel?> getWorkOutByLevelID({levelID = ""}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    // waitDialog();
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    var url = HttpUrls.WS_GET_WORKOUT_BY_LEVELID + levelID;
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        WorkoutReponseModel dataResponse = WorkoutReponseModel.fromJson(data);
        return dataResponse;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<ExerciseReponseModel?> getExerciseByWorkOutID({workOutID = ""}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    // waitDialog();
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    var url = HttpUrls.WS_GET_EXERCISE_BY_WORKOUTID + workOutID;
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["data"];
        if (obj != null) {
          ExerciseReponseModel dataResponse =
              ExerciseReponseModel.fromJson(obj);
          print("dataResponse${dataResponse}");
          return dataResponse;
        }
        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool?> startWorkOut({workOutID = ""}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    // waitDialog();
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    var url = HttpUrls.WS_STARTWORKOUT;
    print(url);
    var param = {"workout_id": workOutID};
    var body = json.encode(param);
    try {
      Response response =
          await post(Uri.parse(url), headers: header, body: body);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["data"];
        if (obj != null) {
          return null;
        }
        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          // showAlert(LocalString.msgSessionExpired, onTap: () {
          //   Routes.gotoMainScreen();
          // });
        } else {
          //showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool?> completeWorkOut({workOutID = ""}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    waitDialog();
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    var url = HttpUrls.WS_COMPLETEWORKOUT + workOutID;
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return null;
    }
  }
}
