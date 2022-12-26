import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/timeSlotModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/businessCatModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';

import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/utils/exportPackages.dart';

import '../../authScreens/authManager/models/userBusinesModel.dart';

class AppointmentApi {
  Future<List<BusinessCatModel>?> getBusinessCat() async {
    List<BusinessCatModel> category = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return category;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      // "content-type": 'application/json',
    };
    try {
      print(HttpUrls.WS_GETALLBUSINESSCATGORY);

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
          category = cat;
          return category;
        } else {
          return category;
        }
      } else {
        showAlert(data['message'].toString());
        return category;
      }
    } catch (e) {
      print(e.toString());
      showErrorAlert(e.toString());
      return category;
    }
  }

  Future<List<UserBusinessModel>?> getBusinessByCatID({id = ""}) async {
    List<UserBusinessModel> businsess = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return businsess;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      // "content-type": 'application/json',
    };
    try {
      var url = HttpUrls.WS_GETALLBUSINESSCATGORY_ID + id;
      print(url);

      Response response = await get(Uri.parse(url), headers: header);

      var data = jsonDecode(response.body);
      print('${data}');

      if (data['status'] == true) {
        print(data["business"]);

        var allCat = data["business"] as List;
        if (allCat.length > 0) {
          List<UserBusinessModel> cat =
              allCat.map((e) => UserBusinessModel.fromJson(e)).toList();
          businsess = cat;
          return businsess;
        } else {
          return businsess;
        }
      } else {
        //showAlert(data['message'].toString());
        return businsess;
      }
    } catch (e) {
      print(e.toString());
      showErrorAlert(e.toString());
      return businsess;
    }
  }

  Future<double?> getAdvancedPriceByServiceByID({serviceID = ""}) async {
    double advancePrice = 0.0;
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return advancePrice;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    var id = serviceID;
    var url = HttpUrls.WS_GET_ADVANCE_PRICE_BYSERVICE_ID + id.toString();
    print(url);
    //waitDialog();
    List<ServiceItemDataModel> dataList = [];
    try {
      //  waitDialog();
      Response response = await get(Uri.parse(url), headers: header);
      //dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');
      if (data['status'] == true) {
        // dismissWaitDialog();
        print("result ${data["data"]}");
        var price = double.tryParse(data["advance"].toString()) ?? 0.0;
        advancePrice = price;
        return advancePrice;
      } else {
        //  dismissWaitDialog();
        showAlert(data['message'].toString());
        return advancePrice;
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      // dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return advancePrice;
    }
  }

  Future<List<ServiceItemDataModel>?> getUserBusinessServices(
      {businessId = ""}) async {
    List<ServiceItemDataModel> servicesbusinsess = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);

      return servicesbusinsess;
    }
    var token = await LocalStore().getToken();
    var header = {
      "Authorization": token,
      "content-type": 'application/json',
    };
    var id = businessId;
    var url = HttpUrls.WS_GETBUSINESSOWNERSERVICES + id;
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
        return servicesbusinsess;
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      //  dismissWaitDialog();
      print(e.toString());
      showErrorAlert(e.toString());
      return servicesbusinsess;
    }
  }

  Future<List<TimeSlotItemModel>?> getAppointmentTimeSlot({
    required BuildContext context,
    required String date,
    required String business_id,
  }) async {
    var token = await LocalStore().getToken();
    List<TimeSlotItemModel> slotsData = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return slotsData;
    }

    var param = {
      "appointment_date": date,
      "business_id": business_id,
    };
    print(param);
    var id = business_id;

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_GET_TIME_SLOT;

    var pBody = json.encode(param);

    //waitDialog();

    try {
      Response response =
          await post(Uri.parse(url), body: pBody, headers: headers);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        if (data['slots'] == null) {
          return slotsData;
        }
        var slots = data['slots'] as List;
        if (slots.isNotEmpty) {
          List<TimeSlotItemModel> data =
              slots.map((e) => TimeSlotItemModel.fromJson(e, date)).toList();
          return data;
        } else {
          return slotsData;
        }
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return slotsData;
        }
      }
    } catch (e) {
      print(e.toString());
      return slotsData;
    }
  }

  Future<bool?> addAppointment({
    required BuildContext context,
    required String business_id,
    required String business_user_id,
    required String booked_user_name,
    required String booked_user_phone_no,
    required String booked_user_email,
    required String appt_date,
    required String appt_start_time,
    required String t_id,
    required String service_id,
    String advance_payment = "0",
    String booked_user_message = "",
  }) async {
    var token = await LocalStore().getToken();

    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var param = {
      "business_id": business_id,
      "business_user_id": business_user_id,
      "booked_user_name": booked_user_name,
      "booked_user_phone_no": booked_user_phone_no,
      "booked_user_email": booked_user_email,
      "appt_date": appt_date,
      "appt_start_time": appt_start_time,
      "t_id": t_id,
      "booked_user_message": booked_user_message,
      "service_id": service_id,
      "advance_payment": advance_payment,
    };

    var id = business_id;

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_ADD_APPOINTMENT;
    print(url);
    var pBody = json.encode(param);
    print(pBody);
    waitDialog();

    try {
      Response response =
          await post(Uri.parse(url), body: pBody, headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        showAlert(data['message'].toString());
        Constant.appointmentProvider.getAppointment();
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          dismissWaitDialog();
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<bool?> addAppointmentWithAdvancePrice({
    required BuildContext context,
    required String business_id,
    required String business_user_id,
    required String booked_user_name,
    required String booked_user_phone_no,
    required String booked_user_email,
    required String appt_date,
    required String appt_start_time,
    required String t_id,
    required String service_id,
    String advance_payment = "0",
    String booked_user_message = "",
    String card_number = "",
    String exp_month = "",
    String exp_year = "",
    String cvc = "",
  }) async {
    var token = await LocalStore().getToken();

    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var param = {
      "business_id": business_id,
      "business_user_id": business_user_id,
      "booked_user_name": booked_user_name,
      "booked_user_phone_no": booked_user_phone_no,
      "booked_user_email": booked_user_email,
      "appt_date": appt_date,
      "appt_start_time": appt_start_time,
      "t_id": t_id,
      "booked_user_message": booked_user_message,
      "service_id": service_id,
      "advance_payment": advance_payment,
      "card_number": card_number,
      "exp_month": exp_month,
      "exp_year": exp_year,
      "cvc": cvc
    };

    var id = business_id;

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_ADD_APPOINTMENT_WITH_ADVANCE_PAY;
    print(url);
    var pBody = json.encode(param);
    print(pBody);
    waitDialog();

    try {
      Response response =
          await post(Uri.parse(url), body: pBody, headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        showAlert(data['message'].toString());
        Constant.appointmentProvider.getAppointment();
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          dismissWaitDialog();
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<List<BookedAppointmentModel>?> getMyAppointmentList() async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return bookedAppointment;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_GET_MY_APPOINTMENT;
    print(url);
    //waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var list = data['data'] as List;
        if (list.isNotEmpty) {
          bookedAppointment =
              list.map((e) => BookedAppointmentModel.fromJson(e)).toList();
          return bookedAppointment;
        } else {
          return bookedAppointment;
        }
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return bookedAppointment;
        }
      }
    } catch (e) {
      print(e.toString());
      return bookedAppointment;
    }
  }

  Future<List<BookedAppointmentModel>?> getBizOwnerAppointmentList() async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return bookedAppointment;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_GET_BIZOWNER_APPOINTMENTList;
    print(url);
    //waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var list = data['data'] as List;
        if (list.isNotEmpty) {
          bookedAppointment =
              list.map((e) => BookedAppointmentModel.fromJson(e)).toList();
          return bookedAppointment;
        } else {
          return bookedAppointment;
        }
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return bookedAppointment;
        }
      }
    } catch (e) {
      print(e.toString());
      return bookedAppointment;
    }
  }

  Future<BookedAppointmentModel?> getAppointmentDataByID({id = ""}) async {
    var token = await LocalStore().getToken();
    BookedAppointmentModel bookedAppointment = BookedAppointmentModel();
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return bookedAppointment;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_GET_USER_APPOINTMENTDETAILBY_ID + id;
    print(url);
    //waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        var list = data['data'];
        if (list != null) {
          bookedAppointment = BookedAppointmentModel.fromJson(list);
          return bookedAppointment;
        } else {
          return bookedAppointment;
        }
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return bookedAppointment;
        }
      }
    } catch (e) {
      print(e.toString());
      return bookedAppointment;
    }
  }

  Future<bool?> rescheduleBooking(
      {appointmentID = "", appt_start_time = "", appt_date = ""}) async {
    var token = await LocalStore().getToken();

    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }
    var param = {
      "appt_id": appointmentID,
      "appt_date": appt_date,
      "appt_start_time": appt_start_time
    };
    var url = HttpUrls.WS_RESCHEDULE_BOOKING;

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    print(url);
    var pBody = json.encode(param);
    print(pBody);
    waitDialog();

    try {
      Response response =
          await post(Uri.parse(url), body: pBody, headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        dismissWaitDialog();
        showAlert(data['message'].toString());
        Constant.appointmentProvider.getAppointment();
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          dismissWaitDialog();
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<bool?> cancelBooking(appointmentID) async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_CANCEL_BOOKING + appointmentID;
    print(url);
    waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        showAlert(data['message'].toString());
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<bool?> rejectBooking(appointmentID) async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_REJECT_BOOKING + appointmentID;
    print(url);
    waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        showAlert(data['message'].toString());
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<bool?> acceptBooking(appointmentID) async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_ACCEPT_BOOKING + appointmentID;
    print(url);
    waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        showAlert(data['message'].toString());
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<bool?> completeBooking(appointmentID) async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_COMPLETE_BOOKING + appointmentID;
    print(url);
    waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        showAlert(data['message'].toString());
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<bool?> askForPayment(appointmentID) async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_ASK_FOR_PAYMENT + appointmentID;
    print(url);
    waitDialog();

    try {
      Response response = await get(Uri.parse(url), headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        showAlert(data['message'].toString());
        return true;
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<bool?> userPayment(
      {appointmentID = "",
      cardNumber = "",
      cvv = "",
      expDate = "",
      onSuccess}) async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }
    var splitDate = expDate.toString().split("/");
    var expMonth = splitDate[0];
    var expYear = splitDate[1];
    var body = {
      "appt_id": appointmentID,
      "card_number": cardNumber,
      "exp_month": expMonth,
      "exp_year": expYear,
      "cvc": cvv
    };
    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_PENDING_DUE_PAYNOW;
    print(url);
    var request = json.encode(body);
    print(request);
    waitDialog();

    try {
      Response response =
          await post(Uri.parse(url), body: request, headers: headers);
      dismissWaitDialog();
      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        showAlert(data['message'].toString(), onTap: () {
          onSuccess();
        });
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      dismissWaitDialog();
      print(e.toString());
      return false;
    }
  }

  Future<bool?> submitRating(
      {appointmentID = "",
      service_id = "",
      rating = "",
      comment = "",
      onSuccess}) async {
    var token = await LocalStore().getToken();
    List<BookedAppointmentModel> bookedAppointment = [];
    if (await internetCheck() == false) {
      showAlert(LocalString.internetNot);
      return false;
    }

    var body = {
      "appt_id": appointmentID,
      "service_id": service_id,
      "rating": rating,
      "comment": comment
    };
    var headers = {"Authorization": token, 'Content-Type': 'application/json'};

    var url = HttpUrls.WS_RATING_SUBMIT;
    print(url);
    var request = json.encode(body);
    print(request);

    try {
      Response response =
          await post(Uri.parse(url), body: request, headers: headers);

      var data = json.decode(response.body);
      print('${data}');

      if (data['status'] == true) {
        // showAlert(data['message'].toString(), onTap: () {
        //   onSuccess();
        // });
      } else {
        if (data["auth_code"] != null || token == null) {
          showAlert(LocalString.msgSessionExpired, onTap: () {
            Routes.gotoMainScreen();
          });
        } else {
          showAlert(data['message'].toString());
          return false;
        }
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
