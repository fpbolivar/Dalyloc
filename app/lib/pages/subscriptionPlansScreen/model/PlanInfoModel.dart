import 'package:daly_doc/pages/settingsScreen/model/allPlanMode.dart';
import 'package:intl/intl.dart';

enum PlanType { free, monthly, yearly }

extension PlanTypeString on String {
  PlanType get planType {
    switch (this) {
      case 'free':
        return PlanType.free;
      case 'monthly':
        return PlanType.monthly;
      case 'yearly':
        return PlanType.yearly;
      case 'annually':
        return PlanType.yearly;

      default:
        return PlanType.free;
    }
  }
}

extension TopicExtension on PlanType {
  String get rawValue {
    switch (this) {
      case PlanType.free:
        return 'free';
      case PlanType.monthly:
        return 'month';
      case PlanType.yearly:
        return 'year';
    }
  }
}

enum ContentType {
  choice,
  text,
}

class PlanInfoModel {
  String title = "";
  int id = 0;
  String description = "";
  String btnTitle = "";
  String price = "";
  String image = "";
  String plan_type = "";
  String plan_id = "";
  String plan_operation = "";
  String subscription_status = "";
  String amount = "";
  String subscription_id = "";
  String start_date = "";
  String end_date = "";
  String end_dateFormat = "";
  ContentType contextType = ContentType.text;
  PlanType periodDuration;
  List<SubscriptionSubPlansModel>? planList;
  PlanInfoModel(
      {this.title = "",
      this.id = 0,
      this.description = "",
      this.btnTitle = "",
      this.price = "",
      this.image = "",
      this.contextType = ContentType.text,
      this.periodDuration = PlanType.monthly,
      this.planList,
      this.end_date = "",
      this.plan_id = "",
      this.start_date = "",
      this.subscription_id = "",
      this.subscription_status = "",
      this.plan_operation = "",
      this.plan_type = "",
      this.end_dateFormat = "",
      this.amount = ""});

  factory PlanInfoModel.fromJson(Map<String, dynamic> json) {
    var data = json["detail"] as List;
    List<SubscriptionSubPlansModel> subPlanlist = [];
    data.forEach(
      (element) {
        subPlanlist.add(SubscriptionSubPlansModel.fromJson(element));
      },
    );
    var titleTemp = "";
    if (subPlanlist.length > 0) {
      titleTemp = subPlanlist.first.title ?? "";
    }

    DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(
      json["end_date"].toString(),
    );
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd,yyyy');
    var outputDate = outputFormat.format(inputDate);
    return PlanInfoModel(
      planList: subPlanlist,
      id: json["id"] ?? 0,
      title: titleTemp,
      end_dateFormat: outputDate,
      start_date: json["start_date"].toString(),
      end_date: json["end_date"].toString(),
      subscription_id: json["subscription_id"].toString(),
      amount: json["amount"].toString(),
      periodDuration: json["plan_type"].toString().planType,
      subscription_status: json["subscription_status"].toString(),
      plan_operation: json["plan_operation"].toString(),
      plan_type: json["plan_type"].toString(),
      plan_id: json["plan_id"].toString(),
    );
  }
}
