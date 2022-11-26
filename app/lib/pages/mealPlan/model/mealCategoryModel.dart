import 'package:daly_doc/core/apisUtils/httpUrls.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';

class MealCategoryModel {
  int? categoryId;
  String? categoryName;
  List<MealItemModel>? data;
  MealCategoryModel({this.categoryId, this.categoryName, this.data});

  factory MealCategoryModel.fromJson(Map<String, dynamic> json) {
    print("REC");
    final data = json['recipes'] as List;
    List<MealItemModel> tempList = [];
    print("REC$data");
    if (data.isNotEmpty) {
      tempList =
          data.map((element) => MealItemModel.fromJson(element)).toList();
    }
    return MealCategoryModel(
      categoryId: json['id'],
      categoryName: json['name'].toString(),
      data: tempList,
    );
  }
  factory MealCategoryModel.fromUserReceipeJson(Map<String, dynamic> json) {
    final data = json['recipes'] as List;
    List<MealItemModel> tempList = [];
    var finalDateStr = "";
    if (data.isNotEmpty) {
      data.forEach((element) {
        var item = element["user_meal_plan_recipes"] as List;

        tempList.add(MealItemModel.fromJson(item.first));
      });
    }
    var now = DateTime.now();
    var systemDate = TaskManager().dateParseyyyyMMdd(now);
    var dateTemp = json['cooking_date'].toString();

    if (systemDate == dateTemp) {
      finalDateStr = "Today";
    } else {
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      systemDate = TaskManager().dateParseyyyyMMdd(yesterday);
      if (systemDate == dateTemp) {
        finalDateStr = "Yesterday";
      } else {
        final dateTimeObj = TaskManager().dateObjFromStr(dateTemp);
        dateTemp = TaskManager().dateParseMMMddyyyy(dateTimeObj);
        finalDateStr = dateTemp;
      }
    }
    return MealCategoryModel(
      categoryId: json['id'] ?? 0,
      categoryName: finalDateStr,
      data: tempList,
    );
  }
}

class MealItemModel {
  bool? isSelected;

  String? meal_category_id;
  String? menu_type_id;
  String? meal_cookware_id;
  String? meal_name;
  String? full_meal_image_url;
  String? meal_cooking_timing;
  String? meal_image;
  String? meal_calories;
  int? id;
  MealItemModel({
    this.isSelected,
    this.meal_category_id,
    this.meal_image,
    this.full_meal_image_url,
    this.meal_calories,
    this.meal_cooking_timing,
    this.meal_name,
    this.meal_cookware_id,
    this.menu_type_id,
    this.id,
  });

  factory MealItemModel.fromJson(Map<String, dynamic> json) {
    print("======${json}");
    return MealItemModel(
      isSelected: false,
      meal_category_id: json['meal_category_id'].toString(),
      id: json['id'] ?? 0,
      meal_image: json['meal_image'].toString(),
      full_meal_image_url: HttpUrls.WS_BASEURL + json['meal_image'].toString(),
      meal_calories: json['meal_calories'].toString() + " kcal",
      meal_cooking_timing: json['meal_cooking_timing'].toString(),
      meal_name: json['meal_name'].toString(),
      meal_cookware_id: json['meal_cookware_id'].toString(),
      menu_type_id: json['menu_type_id'].toString(),
    );
  }
}
