import 'dart:convert';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/bankDetailModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/businessCatModel.dart';

import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:http/http.dart' as http;
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/dialogs/CommonDialogs.dart';

import '../../../../core/LocalString/localString.dart';
import '../../../../core/apisUtils/internetCheck.dart';
import '../../../../core/constant/constants.dart';
import '../models/userBusinesModel.dart';

class BusinessApis {
  static var refreshService = false;
  getUserBusiness(onSuccess) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    print(HttpUrls.WS_GETBUSINESS);
    try {
      Response response =
          await get(Uri.parse(HttpUrls.WS_GETBUSINESS), headers: header);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        print("result ${data["data"]}");
        var allCat = data["data"];
        print('${allCat}');
        UserBusinessModel obj = UserBusinessModel.fromJson(allCat);
        onSuccess(obj);
        //().businessAddress = allCat['business_address'];

        // print(allCat);
        // if (allCat.length > 0) {
        //   List<UserBusinessModel> rex =
        //       allCat.map((e) => ).toList();
        //   print("dataLength ${rex.length}");
        //   onSuccess(rex);
        // }
      } else {
        dismissWaitDialog();
        showAlert(data['message'].toString());
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());

      // showErrorAlert(e.toString());
    }
  }

  Future<UserBusinessModel?> getUserBusinessDetail({needLoader = true}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    print(HttpUrls.WS_GETBUSINESS);
    try {
      if (needLoader) {
        waitDialog();
      }
      Response response =
          await get(Uri.parse(HttpUrls.WS_GETBUSINESS), headers: header);
      if (needLoader) {
        dismissWaitDialog();
      }
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        if (needLoader) {
          dismissWaitDialog();
        }
        print("result ${data["data"]}");
        var allCat = data["data"];
        print('${allCat}');
        UserBusinessModel obj = UserBusinessModel.fromJson(allCat);
        await LocalStore().setBusinessId(obj.id.toString());
        return obj;
      } else {
        if (needLoader) {
          dismissWaitDialog();
        }
        // showAlert(data['message'].toString());
        return null;
      }
    } catch (e) {
      if (needLoader) {
        dismissWaitDialog();
      }
      print(e.toString());
      return null;
    }
  }

  Future<List<PlanInfoModel>?> getActivePlan(
      {onSuccess, needLoader = true}) async {
    List<PlanInfoModel> temp = [];
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return temp;
    }

    var header = {
      "Authorization": token,
    };

    var url = HttpUrls.WS_GETACTIVEPLANS;
    print(url);
    if (needLoader) {
      waitDialog();
    }
    try {
      Response response = await get(
        Uri.parse(url),
        headers: header,
      );
      if (needLoader) {
        dismissWaitDialog();
      }
      print(url);
      var data = jsonDecode(response.body);
      print('${data}');

      if (data["status_code"] == true) {
        var list = data["activeplans"] as List;
        if (list.length > 0) {
          List<PlanInfoModel> listPlan =
              list.map((obj) => PlanInfoModel.fromJson(obj)).toList();
          return listPlan;
        } else {
          List<PlanInfoModel> temp = [];
          return temp;
        }
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          List<PlanInfoModel> listPlan = [];

          showAlert(data['message'].toString());
          return listPlan;
        }
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      if (needLoader) {
        dismissWaitDialog();
      }
      print(e.toString());
      showErrorAlert(e.toString());

      return temp;
    }
  }

  Future<List<ServiceItemDataModel>?> getUserBusinessServices() async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    var id = await LocalStore().getBusinessId();
    var url = HttpUrls.WS_GETBUSINESSSERVICES + id;
    print(url);
    List<ServiceItemDataModel> dataList = [];
    try {
      //  waitDialog();
      Response response = await get(Uri.parse(url), headers: header);

      var data = json.decode(response.body);
      print('${data}');
      if (data['status'] == true) {
        // dismissWaitDialog();
        print("result ${data["data"]}");
        var list = data["data"] as List;

        if (list == null) {
          return dataList;
        }
        if (list.isEmpty) {
          return dataList;
        } else {
          dataList = list.map((e) => ServiceItemDataModel.fromJson(e)).toList();
          return dataList;
        }
      } else {
        //  dismissWaitDialog();
        showAlert(data['message'].toString());
        return null;
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      //  dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  Future<ServiceItemDataModel?> getBusinessServicesByID({id = ""}) async {
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return null;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };

    var url = HttpUrls.WS_GETBUSINESSSERVICES_BYID + id;
    print(url);
    ServiceItemDataModel? dataList;
    try {
      waitDialog();
      Response response = await get(Uri.parse(url), headers: header);

      var data = json.decode(response.body);
      print('${data}');
      if (data['status'] == true) {
        dismissWaitDialog();
        print("result ${data["data"]}");
        var list = data["data"];

        if (list == null) {
          return dataList;
        }
        if (list.isEmpty) {
          return dataList;
        } else {
          dataList = ServiceItemDataModel.fromJson(list);
          return dataList;
        }
      } else {
        dismissWaitDialog();
        showAlert(data['message'].toString());
        return null;
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return null;
    }
  }

  createBusiness({
    onSuccess,
    required String name,
    image = '',
    String lat = '',
    String long = '',
    String address = "",
    required String email,
    required String businessCategoryId,
  }) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    if (name.toString().isEmpty) {
      showAlert("Enter business name");
      print("Enter Name");
      return;
    } else if (email.toString().isEmpty) {
      showAlert("Enter email ");
      print("Enter email ");
      return;
    } else if (!Validator.isValidEmail(email)) {
      showAlert("Enter valid email ");

      return;
    } else if (businessCategoryId.toString().isEmpty) {
      showAlert("Select business category");
      print("Select Business Category");
      return;
    }
    waitDialog();

    var headers2 = {"Authorization": token, 'Content-Type': 'application/json'};
    var url = HttpUrls.WS_CREATEBUSINESS;

    var header = {
      "Authorization": token,
      // "content-type": 'application/json',
    };
    var param = {
      'business_name': name,
      'business_email': email,
      'business_category_id': businessCategoryId
    };
    print(param);
    print(url);
    try {
      Response response =
          await post(Uri.parse(url), headers: header, body: param);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        print(data["user_business"]);
        await LocalStore().setBusinessSlug(data["booking_url"].toString());
        await LocalStore()
            .setBusinessId(data["user_business"]["id"].toString());

        print("${data["user_business"]["user_id"]} . ${data["booking_url"]}");
        onSuccess();
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

  createNewService({
    required BuildContext context,
    onSuccess,
    required String serviceName,
    required String price,
    required String Duration,
    required String deposit_percentage,
  }) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    if (serviceName.toString().isEmpty) {
      showAlert("Enter service name");
      print("Enter service name");
      return;
    } else if (price.toString().isEmpty) {
      showAlert("Enter price ");
      print("Enter price ");
      return;
    } else if (Duration.toString().isEmpty) {
      showAlert("Enter Duration");
      print("Enter Duration");
      return;
    } else if (deposit_percentage.toString().isEmpty) {
      showAlert("Enter Duration");
      print("Enter Duration");
      return;
    }
    var id = await LocalStore().getBusinessId();
    var headers = {"Authorization": token, 'Content-Type': 'application/json'};
    var url = HttpUrls.WS_CREATEBUSINESSSERVICES;

    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "business_id": id,
      "service_name": serviceName,
      "service_price": price,
      "service_time": Duration,
      "service_online_booking": "1",
      "deposit_percentage": deposit_percentage
    });
    request.headers.addAll(headers);
    waitDialog();
    var response = await Response.fromStream(await request.send());
    dismissWaitDialog();

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      BusinessApis.refreshService = true;
      onSuccess();

      showAlert(
        data['message'],
      );

      print(await response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  getTimingObject(
      {bool firstTimeCreated = true, required List<WeekDaysModel> weekDays}) {
    var obj1 = [];

    if (firstTimeCreated) {
      weekDays.forEach((element) {
        var st = element.startime!.timeStr.toString();
        var et = element.endtime!.timeStr.toString();

        st = st = st == "" ? "" : TaskManager().convertTo24hrs(st);
        st = st = st == "" ? "" : TaskManager().generateUtcTime(time: st);
        et = et = et == "" ? "" : TaskManager().convertTo24hrs(et);
        et = et = et == "" ? "" : TaskManager().generateUtcTime(time: et);
        obj1.add({
          "day": element.name,
          "is_closed": element.selected == true ? "0" : "1",
          "open_time": st == "" ? "00:00" : st,
          "close_time": et == "" ? "00:00" : et,
        });
      });
    } else {
      weekDays.forEach((element) {
        var st = element.startime!.timeStr.toString();
        var et = element.endtime!.timeStr.toString();

        st = st == "" ? "" : TaskManager().convertTo24hrs(st);
        st = st == "" ? "" : TaskManager().generateUtcTime(time: st);
        et = et == "" ? "" : TaskManager().convertTo24hrs(et);
        et = et == "" ? "" : TaskManager().generateUtcTime(time: et);

        obj1.add({
          "day": element.name,
          "timing_id": element.id,
          "is_closed": element.selected == true ? "0" : "1",
          "open_time": st == "" ? "00:00" : st,
          "close_time": et == "" ? "00:00" : et,
        });
      });
    }
    return obj1;
  }

  createBusinesTiming(
      {required List<WeekDaysModel> weekDays, onSuccess}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    var id = await LocalStore().getBusinessId();
    var headers = {"Authorization": token, 'Content-Type': 'application/json'};
    var url = HttpUrls.WS_CREATEBUSINESSTIMING;
    print(url);

    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.body = json.encode({
      "business_id": id,
      "timing": getTimingObject(
          weekDays: weekDays, firstTimeCreated: weekDays.first.id == "0")
    });
    print(request.body);
    waitDialog();
    var response = await Response.fromStream(await request.send());
    dismissWaitDialog();

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      onSuccess();
      showAlert(
        data['message'],
      );

      print(await response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  createUpdateService({
    required BuildContext context,
    onSuccess,
    required String serviceName,
    required String price,
    required String Duration,
    required String serviceID,
    required String deposit_percentage,
  }) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    if (serviceName.toString().isEmpty) {
      showAlert("Enter service name");
      print("Enter service name");
      return;
    } else if (price.toString().isEmpty) {
      showAlert("Enter price ");
      print("Enter price ");
      return;
    } else if (Duration.toString().isEmpty) {
      showAlert("Enter Duration");
      print("Enter Duration");
      return;
    } else if (deposit_percentage.toString().isEmpty) {
      showAlert("Enter Duration");
      print("Enter Duration");
      return;
    }
    var id = await LocalStore().getBusinessId();
    var headers = {"Authorization": token, 'Content-Type': 'application/json'};
    var url = HttpUrls.WS_UPDATEBUSINESSSERVICES;
    print(url);
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "business_id": id,
      "business_service_id": serviceID,
      "service_name": serviceName,
      "service_price": price,
      "service_time": Duration,
      "service_online_booking": "1",
      "deposit_percentage": deposit_percentage
    });
    print(request.body);
    request.headers.addAll(headers);
    waitDialog();
    var response = await Response.fromStream(await request.send());
    dismissWaitDialog();

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      BusinessApis.refreshService = true;
      onSuccess();

      showAlert(
        data['message'],
      );

      print(await response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  setTimeSlot(String slot) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    waitDialog();
    var id = await LocalStore().getBusinessId();
    var headers = {"Authorization": token, 'Content-Type': 'application/json'};
    var url = HttpUrls.WS_EDITBUSINESSTIMESLOT;

    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"business_id": id, "slot_interval": slot});
    request.headers.addAll(headers);

    var response = await Response.fromStream(await request.send());

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dismissWaitDialog();
      showAlert(data['message'], onTap: () {
        Navigator.of(Constant.navigatorKey.currentState!.overlay!.context);
        Navigator.of(Constant.navigatorKey.currentState!.overlay!.context);
      });
      print(await response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  updateBusiness({
    onSuccess,
    required String name,
    required String id,
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
    if (name.toString().isEmpty) {
      showAlert("Enter business name");
      print("Enter Name");
      return;
    } else if (email.toString().isEmpty) {
      showAlert("Enter email ");
      print("Enter email ");
      return;
    } else if (!Validator.isValidEmail(email)) {
      showAlert("Enter valid email ");

      return;
    } else if (businessCategoryId.toString().isEmpty) {
      showAlert("Select business category");
      print("Select Business Category");
      return;
    }
    waitDialog();
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://codeoptimalsolutions.com/test/daly-doc/public/api/update-user-business'));
    request.fields.addAll({
      "user_business_id": id,
      'business_name': name,
      'business_email': email,
      'business_address': address,
      'lat': lat,
      'lng': long,
      'business_category_id': businessCategoryId
    });
    if (image != "") {
      request.files
          .add(await http.MultipartFile.fromPath('business_image', image));
    }
    request.headers.addAll(headers);

    var response = await Response.fromStream(await request.send());
    dismissWaitDialog();
    print("Result: ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    data["booking_url"].toString();
    await LocalStore().setBusinessSlug(data["booking_url"].toString());

    if (response.statusCode == 200) {
      onSuccess();
      print(response);
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
      print(HttpUrls.WS_GETALLBUSINESSCATGORY);
      waitDialog();
      Response response = await get(
          Uri.parse(HttpUrls.WS_GETALLBUSINESSCATGORY),
          headers: header);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        print(data["data"]);

        var allCat = data["data"] as List;
        if (allCat.length > 0) {
          List<BusinessCatModel> cat =
              allCat.map((e) => BusinessCatModel.fromJson(e)).toList();
          print("catagory ${cat.length}");
          onSuccess(cat);
        }
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

  Future<bool?> getOnlinePaymentStatus(
      {needUpdate = false, value = "0"}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    // waitDialog();

    var url = HttpUrls.WS_GET_UPDATE_PAYMENT_ONLINE;
    if (needUpdate) {
      url = url + "?online_booking=$value";
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
          return obj["online_booking"].toString() == "1";
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

  Future<bool?> getActivePaymentStatus() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    // waitDialog();
    var id = await LocalStore().getBusinessId();
    var url = HttpUrls.WS_GET_ACTIVEPAYMENT + id;

    var header = await HttpUrls.headerData();
    print(url);
    try {
      Response response = await get(Uri.parse(url), headers: header);
      //dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var obj = data["is_active_payment"];
        if (obj != null) {
          print("obj${obj}");
          return obj.toString() == "1";
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

  Future<bool?> updateActivePaymentStatus({String value = "0"}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();
    var id = await LocalStore().getBusinessId();
    var url = HttpUrls.WS_UPDATEACTIVEPAYMENT;
    var header = await HttpUrls.headerData();

    var body = {"user_business_id": id, "is_active_payment": value};
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

  Future<bool?> createAcceptance({String value = "", String bizID = ""}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    waitDialog();
    var id = await LocalStore().getBusinessId();
    var url = HttpUrls.WS_ACCEPTANCEUPDATE;
    var header = await HttpUrls.headerData();

    var body = {"user_business_id": id, "acceptance": value};
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

  Future<bool?> depositPercentage(
      {String value = "", String serviceID = ""}) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    if (value.trim().isEmpty) {
      showAlert("Enter Value");
      return null;
    }
    waitDialog();
    var id = await LocalStore().getBusinessId();
    var url = HttpUrls.WS_DEPOSITPERCENTAGE;
    var header = await HttpUrls.headerData();

    var body = {
      "business_id": id,
      "deposit_percentage": value,
      "id": serviceID
    };
    var request = json.encode(body);
    print(url);
    try {
      Response response =
          await post(Uri.parse(url), body: request, headers: header);
      dismissWaitDialog();
      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        showAlert("Updated deposit percentage.");
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

  addBankDetail({
    required BuildContext context,
    onSuccess,
    required String bankName,
    required String bankID,
    required bool isUpdate,
    required String accountNumber,
    required String country,
    required String cfmaccountNumber,
    required String routingNumber,
    required String userName,
    required String city,
    required String state,
    required String address,
    required String postalCode,
    required String mobileNo,
    required String accountHolderName,
  }) async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return;
    }
    if (bankName.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter bank name");

      return;
    } else if (accountHolderName.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter account holder name");

      return;
    } else if (accountNumber.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter bank account no.");

      return;
    } else if (cfmaccountNumber.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter account no. into confirm box");

      return;
    } else if (cfmaccountNumber.toString() != accountNumber.toString()) {
      ToastMessage.showErrorwMessage(
          msg: "Mismatched account no. with confirm boc of account no.");

      return;
    } else if (routingNumber.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter routing number");

      return;
    } else if (city.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter city");

      return;
    } else if (state.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter state");

      return;
    } else if (address.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter address");

      return;
    } else if (postalCode.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter postal code");

      return;
    } else if (postalCode.toString().isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter phone Number");

      return;
    }
    var param = {
      "object": "bank_account",
      "bank_name": bankName,
      "account_number": accountNumber,
      "country": country,
      "state": state,
      "city": city,
      "address": address,
      "routing_number": routingNumber,
      "account_holder_name": accountHolderName,
      "account_holder_type": "company",
      "postal_code": postalCode
    };
    var url = HttpUrls.WS_AddBankDetail;
    if (isUpdate) {
      if (bankID != "") {
        param["bank_stripe_id"] = bankID;
        url = HttpUrls.WS_UpdateBankDetail;
      }
    }
    var id = await LocalStore().getBusinessId();
    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    print(url);
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(param);
    print(request.body);
    request.headers.addAll(headers);
    waitDialog();
    var response = await Response.fromStream(await request.send());
    dismissWaitDialog();

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);

    if (data['status'] == true) {
      if (data['bank'] != null) {
        showAlert(data['message'].toString());
        onSuccess();
        // showAlert("Your bank account has been submitted for review.");
      }
    } else {
      showAlert(data['message'].toString());
    }

    print(await response.body);
  }

  Future<BankDetailModel?> getBankDetail() async {
    var token = await LocalStore().getToken();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return null;
    }
    // waitDialog();
    var id = await LocalStore().getBusinessId();
    var url = HttpUrls.WS_GET_BANK_DETAIL;

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
          return BankDetailModel.fromJson(obj);
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
}
