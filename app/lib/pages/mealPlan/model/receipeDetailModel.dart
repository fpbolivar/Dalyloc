import 'package:daly_doc/utils/exportPackages.dart';

class ReceipeDetailModel {
  String? meal_category_id;
  String? menu_type_id;
  String? meal_cookware_id;
  String? meal_name;
  String? full_meal_image_url;
  String? meal_cooking_timing;
  String? meal_image;
  String? meal_calories;
  String? description;
  int? id;
  List<CookWareModel>? cookWareList = [];
  List<IngredientModel>? ingredientList = [];
  List<InstructionsModel>? instructionList = [];
  ReceipeDetailModel({
    this.cookWareList,
    this.ingredientList,
    this.instructionList,
    this.meal_category_id,
    this.meal_image,
    this.full_meal_image_url,
    this.meal_calories,
    this.meal_cooking_timing,
    this.description,
    this.meal_name,
    this.meal_cookware_id,
    this.menu_type_id,
    this.id,
  });

  factory ReceipeDetailModel.fromJson(Map<String, dynamic> json) {
    List<CookWareModel> cookWareList_temp = [];
    List<IngredientModel> ingredientList_temp = [];
    List<InstructionsModel> instructionList_temp = [];
    print("ReceipeDetailModel ${json}");
    var cookWare = json['meal_cookware'] as List;
    var ingredint = json['ingredients'] as List;
    var instruction = json['instructions'] as List;

    if (cookWare != null) {
      cookWareList_temp =
          cookWare.map((e) => CookWareModel.fromJson(e)).toList();
    }
    if (ingredint != null) {
      ingredientList_temp =
          ingredint.map((e) => IngredientModel.fromJson(e)).toList();
    }
    if (instruction != null) {
      instructionList_temp =
          instruction.map((e) => InstructionsModel.fromJson(e)).toList();
    }

    return ReceipeDetailModel(
      ingredientList: ingredientList_temp,
      instructionList: instructionList_temp,
      cookWareList: cookWareList_temp,
      meal_category_id: json['meal_category_id'].toString(),
      description: json['description'].toString(),
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

class IngredientModel {
  String? name;
  String? image;
  String? quantity;
  String? description;

  int? id;
  IngredientModel({
    this.name,
    this.quantity,
    this.description,
    this.image,
    this.id,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    var nameTemp = "";
    var image = "";

    var ingredient_detail = json["ingredient_detail"] as List;
    if (ingredient_detail.isNotEmpty) {
      var obj = ingredient_detail.first;
      nameTemp = obj["name"].toString();
      image = obj["image"].toString();
    }
    return IngredientModel(
        name: nameTemp,
        quantity: json['quantity'].toString(),
        id: json['id'] ?? 0,
        image: image,
        description: json['quantity'].toString() + " " + nameTemp);
  }
}

class CookWareModel {
  String? name;
  String? description;

  int? id;
  CookWareModel({
    this.name,
    this.description,
    this.id,
  });

  factory CookWareModel.fromJson(Map<String, dynamic> json) {
    return CookWareModel(
      name: json['name'].toString(),
      id: json['id'] ?? 0,
      description: json['description'].toString(),
    );
  }
}

class InstructionsModel {
  String? step_no;
  String? description;

  int? id;
  InstructionsModel({
    this.step_no,
    this.description,
    this.id,
  });

  factory InstructionsModel.fromJson(Map<String, dynamic> json) {
    return InstructionsModel(
      step_no: json['step_no'].toString(),
      id: json['id'] ?? 0,
      description: json['description'].toString(),
    );
  }
}
