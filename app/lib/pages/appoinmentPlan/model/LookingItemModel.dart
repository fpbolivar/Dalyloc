import 'package:daly_doc/widgets/extension/string+capitalize.dart';

class LookingItemModel {
  bool? isSelected;

  String? id;
  String? title;

  LookingItemModel({
    this.isSelected,
    this.title,
    this.id,
  });

  factory LookingItemModel.fromJson(Map<String, dynamic> json) {
    print("======${json}");
    return LookingItemModel(
      isSelected: false,
      id: json["id"].toString(),
      title: json["title"].toString(),
    );
  }
}
