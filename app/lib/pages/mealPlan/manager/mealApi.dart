import 'dart:convert';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/businessCatModel.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealEnum.dart';
import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/pages/mealPlan/model/foodTagModel.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/mealPlan/model/receipeDetailModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/ApisManager/Apis.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

import '../../../../core/LocalString/localString.dart';
import '../../../../core/apisUtils/internetCheck.dart';

class MealApis {
  Future<List<FoodDietModel>?> getFoodVarient() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_MEAL_ITEMS_BYTYPE + "diet";
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var itemList = data["data"] as List;
        if (itemList.length > 0) {
          List<FoodDietModel> dataMenu =
              itemList.map((e) => FoodDietModel.fromJson(e)).toList();
          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<List<FoodDietModel>?> getMealSize() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_MEAL_ITEMS_BYTYPE + "mealsize";
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var itemList = data["data"] as List;
        if (itemList.length > 0) {
          List<FoodDietModel> dataMenu =
              itemList.map((e) => FoodDietModel.fromJson(e)).toList();
          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<List<FoodTagsModel>?> getAllergiesFood() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_MEAL_ITEMS_BYTYPE + "allergies";
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var itemList = data["data"] as List;
        if (itemList.length > 0) {
          List<FoodTagsModel> dataMenu =
              itemList.map((e) => FoodTagsModel.fromJson(e)).toList();
          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<List<FoodTagsModel>?> getDislikesFood() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_MEAL_ITEMS_BYTYPE + "dislike";
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var itemList = data["data"] as List;
        if (itemList.length > 0) {
          List<FoodTagsModel> dataMenu =
              itemList.map((e) => FoodTagsModel.fromJson(e)).toList();
          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<bool?> getSelectedMealIDs() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_SELECTED_MEALPLAN;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data['data'];
        var status = true;
        if (obj == null) {
          status = false;
          return status;
        }
        if (obj['menu_type_id'] == null) {
          status = false;
        }
        if (obj['menu_type_id'] == "") {
          status = false;
        }

        print(status);
        return status;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<bool?> createMeal(
      {menu_type_id, allergies_id, dislikes_id, meal_size_id}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_CREATE_MEAL;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      var param = {};
      if (menu_type_id != null) {
        param["menu_type_id"] = menu_type_id;
      }
      if (allergies_id != null) {
        param["allergies_id"] = allergies_id;
      }
      if (dislikes_id != null) {
        param["dislikes_id"] = dislikes_id;
      }
      if (meal_size_id != null) {
        param["meal_size_id"] = meal_size_id;
      }
      Response response =
          await post(Uri.parse(url), body: json.encode(param), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<List<MealCategoryModel>?> getReceipeList() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_RECEIPE;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var itemList = data["data"] as List;
        if (itemList.length > 0) {
          List<MealCategoryModel> dataMenu =
              itemList.map((e) => MealCategoryModel.fromJson(e)).toList();
          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<MealCategoryModel?> getReceipeListByCategoryID({id = ""}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_RECEIPE_BY_CAT_ID + id.toString();
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var itemList = data["data"];
        if (itemList != null) {
          MealCategoryModel dataMenu = MealCategoryModel.fromJson(itemList);

          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<bool?> bookOrCreateMeal(List<MealItemModel> data) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_SubmitSelectedMeal;
    var header = await HttpUrls.headerData();
    var jsonReceipe = [];
    String date = TaskManager().dateParseyyyyMMdd(DateTime.now());
    data.forEach((element) {
      jsonReceipe.add({"recipes_id": element.id, "cooking_date": date});
    });
    var body = {"meal_plans": jsonReceipe};
    var request = json.encode(body);
    print(url);
    try {
      Response response =
          await post(Uri.parse(url), body: request, headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<List<MealCategoryModel>?> getUserReceipeData() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_USER_RECEIPE;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var itemList = data["user_meal_plan"] as List;
        if (itemList.length > 0) {
          List<MealCategoryModel> dataMenu = itemList
              .map((e) => MealCategoryModel.fromUserReceipeJson(e))
              .toList();
          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<ReceipeDetailModel?> getReceipeDataByID(id) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_RECEIPE_By_ID + id;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        //"] as List;
        var obj = data['data'];
        if (obj != null) {
          ReceipeDetailModel dataMenu = ReceipeDetailModel.fromJson(obj);
          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<ReceipeDetailModel?> getMyReceipeDataByID(id) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();

    var url = HttpUrls.WS_GET_MY_RECEIPE_By_ID + id;
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        //"] as List;
        var obj = data['data'];
        if (obj != null) {
          ReceipeDetailModel dataMenu = ReceipeDetailModel.fromJson(obj);
          return dataMenu;
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<bool?> getNotification({needUpdate = false, value = "0"}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    // waitDialog();

    var url = HttpUrls.WS_GET_UPDATE_NOTIFICATION;
    if (needUpdate) {
      url = url + "?is_notification=$value";
    }
    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      //dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["data"];
        if (obj != null) {
          return obj["is_notification"].toString() == "1";
        }

        return null;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          showAlert(data['message'].toString());
          return null;
        }
      }
    } catch (e) {
      //dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<bool?> getActivePlanStatus(
      {MealTypePlan type = MealTypePlan.meal}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    // waitDialog();

    var url = HttpUrls.WS_GET_ACTIVESTATUS_BY_TYPE + "${type.rawValue}";

    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      //dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["isActive"];
        if (obj != null) {
          return obj.toString() == "1";
        } else {
          return false;
        }
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
          return null;
        } else {
          // showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      //dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }
}
