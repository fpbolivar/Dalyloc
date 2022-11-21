import 'dart:convert';

import '../../subscriptionPlansScreen/model/PlanInfoModel.dart';

class GetAllPlansModel {
  String? title;
  int? id;
  String? typeOfOperation;
  List<SubscriptionSubPlansModel>? subscriptionSubPlans;
  GetAllPlansModel(
      {this.title, this.id, this.typeOfOperation, this.subscriptionSubPlans});
  factory GetAllPlansModel.fromJson(Map<String, dynamic> json) {
    var subStr = json["subscription_sub_plans"] as List;
    List<SubscriptionSubPlansModel>? subPlanlist = [];
    if (subStr != null) {
      // print("subStr$subStr");
      // var jsonSubTask = jsonDecode(subStr);
      // print("jsonSubTask$jsonSubTask");
      var data = subStr;
      data.forEach(
        (element) {
          subPlanlist.add(SubscriptionSubPlansModel(
            description: element["description"].toString(),
            id: element["id"] ?? 0,
            subscriptionPlanId: element['subscription_plan_id'],
            title: element["name"].toString(),
            type: element["type"].toString(),
            price: element["amount"].toString(),
            operationType: element["type_of_operation"].toString(),
          ));
        },
      );
    }
    print("subTaskslist${subPlanlist.length}");
    return GetAllPlansModel(
        subscriptionSubPlans: subPlanlist,
        id: json['id'],
        title: json['name'].toString(),
        typeOfOperation: json['type_of_operation']);
  }
}

class SubscriptionSubPlansModel {
  int? id;
  int? subscriptionPlanId;
  String? description;
  String? title;
  String? price;
  String? type;
  String? operationType;
  PlanType periodDuration;
  SubscriptionSubPlansModel(
      {this.id,
      this.type,
      this.description,
      this.periodDuration = PlanType.monthly,
      this.operationType,
      this.price,
      this.subscriptionPlanId,
      this.title});
  factory SubscriptionSubPlansModel.fromJson(Map<String, dynamic> element) {
    return SubscriptionSubPlansModel(
      description: element["description"].toString(),
      id: element["id"] ?? 0,
      subscriptionPlanId: element['subscription_plan_id'],
      title: element["name"].toString(),
      type: element["type"].toString(),
      periodDuration: element["type"].toString().planType,
      price: element["amount"].toString(),
      operationType: element["type_of_operation"].toString(),
    );
  }
}
