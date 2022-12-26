import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';

class BookedAppointmentModel {
  String? id;
  String? booked_user_id;
  String? booked_user_name;
  String? booked_user_phone_no;
  String? booked_user_email;
  String? booked_user_message;
  String? appt_status;
  String? is_rating;
  String? business_name;
  String? appt_from;
  String? appt_date;
  String? appt_start_time;
  String? formateDate;
  String? onlyformateDate;
  String? appt_end_time;
  String? appt_local_start_time;
  String? appt_local_end_time;
  String? business_id;
  String? business_user_id;
  String? amount_paid;
  String? pending_payment;
  List<ServiceItemDataModel>? serviceList;

  BookedAppointmentModel({
    this.id,
    this.onlyformateDate,
    this.appt_local_start_time,
    this.appt_local_end_time,
    this.booked_user_id,
    this.business_name,
    this.is_rating,
    this.booked_user_name,
    this.booked_user_phone_no,
    this.booked_user_email,
    this.booked_user_message,
    this.appt_status,
    this.formateDate,
    this.appt_from,
    this.appt_date,
    this.appt_end_time,
    this.serviceList,
    this.appt_start_time,
    this.business_id,
    this.business_user_id,
    this.amount_paid,
    this.pending_payment,
  });

  factory BookedAppointmentModel.fromJson(Map<String, dynamic> json) {
    var list = json["service_detail"];
    List<ServiceItemDataModel>? serviceList = [];
    if (list != null) {
      var dataService = list as List;
      if (dataService.isNotEmpty) {
        serviceList =
            dataService.map((e) => ServiceItemDataModel.fromJson(e)).toList();
      }
    }

    var stime = TaskManager()
        .generateLocalTime(time: json["appt_start_time"].toString());
    var etime =
        TaskManager().generateLocalTime(time: json["appt_end_time"].toString());

    if (!Constant.HRS24FORMAT) {
      stime = TaskManager().timeFromStr12Hrs(stime);
      etime = TaskManager().timeFromStr12Hrs(etime);
    }
    var formateDateTime = TaskManager().yyyyMMdd_To_EEEMMMDDYYYY(
      json["appt_date"].toString(),
    );
    var onlyformateDate = TaskManager().yyyyMMdd_To_MMMDDYYYY(
      json["appt_date"].toString(),
    );

    return BookedAppointmentModel(
      id: json["id"].toString(),
      serviceList: serviceList,
      appt_local_end_time: etime,
      appt_local_start_time: stime,
      formateDate: formateDateTime,
      onlyformateDate: onlyformateDate,
      booked_user_id: json["booked_user_id"].toString(),
      booked_user_name: json["booked_user_name"].toString(),
      booked_user_phone_no: json["booked_user_phone_no"].toString(),
      booked_user_message: json["booked_user_message"].toString() == "null"
          ? ""
          : json["booked_user_message"].toString(),
      booked_user_email: json["booked_user_email"].toString(),
      appt_status: json["appt_status"].toString(),
      business_name: json["business_name"].toString() == "null"
          ? ""
          : json["business_name"].toString(),
      appt_from: json["appt_from"].toString(),
      appt_date: json["appt_date"].toString(),
      appt_start_time: json["appt_start_time"].toString(),
      appt_end_time: json["appt_end_time"].toString(),
      business_id: json["business_id"].toString(),
      is_rating: json["is_rating"].toString(),
      business_user_id: json["business_user_id"].toString(),
      amount_paid: json["amount_paid"].toString() == "null"
          ? ""
          : json["amount_paid"].toString(),
      pending_payment: json["pending_payment"].toString() == "null" ||
              json["pending_payment"].toString() == "0"
          ? ""
          : json["pending_payment"].toString(),
    );
  }
}
