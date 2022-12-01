import 'package:daly_doc/widgets/extension/string+capitalize.dart';

class SavedCardModel {
  bool? isSelected;

  String? object;
  String? brand;
  String? country;
  String? funding;
  String? id;
  String? last4;
  String? defaultStatus;
  SavedCardModel(
      {this.isSelected,
      this.last4,
      this.funding,
      this.country,
      this.brand,
      this.object,
      this.id,
      this.defaultStatus});

  factory SavedCardModel.fromJson(Map<String, dynamic> json) {
    print("======${json}");
    return SavedCardModel(
        isSelected: false,
        id: json["id"].toString(),
        object: json["object"].toString(),
        defaultStatus: json["default"].toString(),
        brand: json["brand"].toString().toUpperCase(),
        country: json["country"].toString(),
        funding: json["funding"].toString(),
        last4: json["last4"].toString());
  }
}
