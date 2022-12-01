import 'package:daly_doc/widgets/extension/string+capitalize.dart';

class ConsultantItemModel {
  bool? isSelected;

  String? id;
  String? title;
  String? description;
  String? price;
  ConsultantItemModel({
    this.isSelected,
    this.description,
    this.price,
    this.title,
    this.id,
  });

  factory ConsultantItemModel.fromJson(Map<String, dynamic> json) {
    print("======${json}");
    return ConsultantItemModel(
      isSelected: false,
      id: json["id"].toString(),
      title: json["title"].toString(),
    );
  }
}
