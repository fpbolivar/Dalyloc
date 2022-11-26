import 'package:daly_doc/core/apisUtils/httpUrls.dart';
import 'package:daly_doc/pages/settingsScreen/model/allPlanMode.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import 'package:intl/intl.dart';

enum FoodDietVarientType { all, pescatarian, vegetarian, vegan }

extension PlanTypeString on String {
  FoodDietVarientType get planType {
    switch (this) {
      case 'all':
        return FoodDietVarientType.all;
      case 'pescatarian':
        return FoodDietVarientType.pescatarian;
      case 'vegetarian':
        return FoodDietVarientType.vegetarian;
      case 'vegan':
        return FoodDietVarientType.vegan;

      default:
        return FoodDietVarientType.all;
    }
  }
}

extension Extension on FoodDietVarientType {
  String get rawValue {
    switch (this) {
      case FoodDietVarientType.all:
        return 'all';
      case FoodDietVarientType.pescatarian:
        return 'pescatarian';
      case FoodDietVarientType.vegetarian:
        return 'vegetarian';
      case FoodDietVarientType.vegan:
        return 'vegan';
    }
  }
}

enum ContentType {
  choice,
  text,
}

class FoodDietModel {
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
  FoodDietVarientType periodDuration;
  bool isSelected = false;
  List<SubscriptionSubPlansModel>? planList;
  FoodDietModel(
      {this.title = "",
      this.id = 0,
      this.description = "",
      this.btnTitle = "",
      this.price = "",
      this.image = "",
      this.contextType = ContentType.text,
      this.periodDuration = FoodDietVarientType.all,
      this.planList,
      this.end_date = "",
      this.plan_id = "",
      this.start_date = "",
      this.subscription_id = "",
      this.subscription_status = "",
      this.plan_operation = "",
      this.plan_type = "",
      this.end_dateFormat = "",
      this.isSelected = false,
      this.amount = ""});

  factory FoodDietModel.fromJson(Map<String, dynamic> json) {
    final imageUrl = HttpUrls.WS_BASEURL + json["image"].toString();
    print(imageUrl);
    return FoodDietModel(
      id: json["id"] ?? 0,
      description: json["description"].toString().capitalize(),
      title: json["name"].toString().capitalize(),
      image: json["image"] == null ? "" : imageUrl,
      isSelected: json['user_selected'].toString() == "1" ? true : false,
    );
  }
}
